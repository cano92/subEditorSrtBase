"
clase concreta que administra el fileSystem
	lee o escribe en fomato SRT
	
	loadFileSRT:aFileName
		-recibe el nombre de un archivo.SRT -aFileName- y genera una colleccion de implementacion de SubtitleComponentSRT
		
	writeFileSRT:aListSubtitleSRT on:aFileName
		-crea un nuevo archivo con formato SRT con el nombre de -aFileName-,  a partir de una colleccion de componentes SubtitleComponentSRT.
"
Class {
	#name : #FileManagerSRT,
	#superclass : #Object,
	#category : #'Obj1-SRT-Editor'
}

{ #category : #private }
FileManagerSRT >> addSubSRT:subSRTCollection on:listResultSRT [
	"evita problema de muchos saltos de linea al final del archivo que genera un bugg"
	( ( subSRTCollection size ) > 2 )ifTrue: [  
		
		listResultSRT add:(self createSubtitleSRT: subSRTCollection ).
	]
	
]

{ #category : #writeFunctions }
FileManagerSRT >> createFileSRT:aFileName [
	"crea un archivo con el nombre aFileName"
	
	^aFileName asFileReference ensureDelete.
]

{ #category : #private }
FileManagerSRT >> createSubtitleSRT:aCollectionSRT [
	"aCollectionSRT at:1  index, aCollectionSRT at:2  timeString, aCollectionSRT at: 3..n  textsubtitle"
	
	^SubtitleSRT newSubtitleTimeString:(aCollectionSRT at:2)  
					text:( self createSubtitleText:aCollectionSRT on:(WriteStream on:(String new)) ) .
]

{ #category : #private }
FileManagerSRT >> createSubtitleText:aCollectionSRT on:aText [
	" comienza en 3 porque ahi inicia el text, concatena las lineas restantes"
	
	3 to: (aCollectionSRT size) 
			do: [:index| aText nextPutAll: (aCollectionSRT at:index). 	aText nextPut: Character lf. ].	
	
	^self finalTextStringClear:aText contents.
]

{ #category : #writeFunctions }
FileManagerSRT >> createWriteString:aIndex subtitle:aSubtitle [

	
	^aIndex asString, self stringLF, aSubtitle printSubtitle, self subtitleSeparatorSRT.
]

{ #category : #private }
FileManagerSRT >> finalTextStringClear:aString [

	aString at:(aString size) put: (Character space).
	^aString.
]

{ #category : #writeFunctions }
FileManagerSRT >> generateStringSRT:aCollectionSRT on:aText [
	"genera un unico String en aText con la lista de subSRT y el salto de linea lf para escribir"
	
	1 to:(aCollectionSRT size)do:
			[:index| aText nextPutAll:( self createWriteString:index subtitle:(aCollectionSRT at:index) ) ].
	^aText contents.
	
]

{ #category : #initialize }
FileManagerSRT >> initialize [ 
	super initialize.
]

{ #category : #public }
FileManagerSRT >> loadFileSRT: aFileSRT [
	" open aFileSRT and  load list subtitles srt"
	
	^self loadFileSRT: aFileSRT  on: (OrderedCollection new ). 
	
]

{ #category : #private }
FileManagerSRT >> loadFileSRT: aFileSRT on:listResultSRT [

	"get subtitles list collection of aFileSRT  "			
	(self subtitleListCollectionSRT: aFileSRT)
		
		"cada subtitulos es convertido en una collecion y cargados en un obj SubSRT"
		do: [:subSRT| self addSubSRT:(subSRT splitOn: Character lf) on:listResultSRT ].
	
	^listResultSRT.
	
]

{ #category : #private }
FileManagerSRT >> openFileSRT: aFileSRT [
	"abre el archivo aFileSRT y lee todo el contenido"
	
	^(aFileSRT asFileReference readStream upToEnd).
]

{ #category : #private }
FileManagerSRT >> stringLF [
	"devuelve el salto de linea en un String para poder concatenarlo"
	
	^String with: Character lf.
]

{ #category : #private }
FileManagerSRT >> subtitleListCollectionSRT: aFileSRT [
	"divide el string en una colleccion de subtitulos por el separador"
	
	^(self openFileSRT: aFileSRT)splitOn: self subtitleSeparatorSRT .
	
	
]

{ #category : #private }
FileManagerSRT >> subtitleSeparatorSRT [
"|separator|"
	"el separador de subtirulos son dos saltos de linea"
	^String with: Character lf with: Character lf.
	
	"separator:= WriteStream on: (String new).
	separator nextPut:Character lf.	
	separator nextPut:Character lf.
	 ^separator contents."
	
]

{ #category : #public }
FileManagerSRT >> writeFileSRT: aListSubSRT on:aFileNameSRT [
			
			
	( self createFileSRT: aFileNameSRT ) writeStreamDo: 
			[ :stream | stream nextPutAll:( self generateStringSRT:aListSubSRT on:(WriteStream on:(String new))  )].
	
	
	
	
]
