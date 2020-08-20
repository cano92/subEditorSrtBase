"
clase concreta que implementa protocolo SubtitleComponentSRT
	necesita parametros para inicializar variables locales
	
	
	contructor con String -- el string aTimeString debe tener el formato  =>  '00:00:37,078 --> 00:00:40,915'
		
		-SubtitleSRT newSubtitleTimeString:aTimeString text:aString
	
	
	constructor con clases Duration
	
		-SubtitleSRT newSubtitleTimeIni: aDuration timeFin: aDuration  text: aString 		


		
		
"
Class {
	#name : #SubtitleSRT,
	#superclass : #SubtitleComponentSRT,
	#instVars : [
		'timeIni',
		'timeFin',
		'text'
	],
	#category : #'Obj1-SRT-Editor'
}

{ #category : #construction }
SubtitleSRT class >> newSubtitleTimeIni:aDurationIni timeFin:aDurationFin text:aString [
		
		
		^self new timeIni:aDurationIni; timeFin:aDurationFin; text:aString .
]

{ #category : #construction }
SubtitleSRT class >> newSubtitleTimeString:aTimeString text:aString [
	"  '00:00:00,625 --> 00:00:03,837' aTimeString format "
		
		^self new  readTimeString: aTimeString; text:aString.
		
]

{ #category : #public }
SubtitleSRT >> advanceTime:aDuration [

	self timeIni: self timeIni + aDuration.
	self timeFin: self timeFin + aDuration.
]

{ #category : #public }
SubtitleSRT >> backTime:aDuration [

	self timeIni: self timeIni - aDuration.
	self timeFin: self timeFin - aDuration.
]

{ #category : #private }
SubtitleSRT >> digitFormat:aDigit [
	"si el nro de es menor a 9 le agrega un cero y lo convierte en String "
	
	(aDigit < 10)ifTrue: [ ^'0{1}' format: { aDigit } 	].
	^aDigit asString.
]

{ #category : #validation }
SubtitleSRT >> isValidtime [

	^( self timeFin > self timeIni ).
]

{ #category : #private }
SubtitleSRT >> milliSecFormat:aMilliSec [
	"convierte los milliSeconds de Duration - en 3 digitos milliSeconds de String "
	
	"si es menor a 9 agregar dos ceros - si es menor a 99 agreagar un cero"
	(aMilliSec<9)ifTrue: [ ^'00{1}' format: { aMilliSec }  ].
	(aMilliSec<99)ifTrue: [ ^'0{1}' format: { aMilliSec } ].
	
	"si es mayor a 99 solo quedarse con los ultimos digitos"
	^self 	milliSecFormatConv: (aMilliSec asString).
	
]

{ #category : #private }
SubtitleSRT >> milliSecFormatConv:aStringMilliSec [
	"aStringMilliSec trae la duracion Total viene en milliSegundos solo se necesitan los ultimos 3 dig"
	^'{1}{2}{3}' format: {
					aStringMilliSec at:( (aStringMilliSec size)-2 ).
					aStringMilliSec at:( (aStringMilliSec size)-1 ).
					aStringMilliSec at:( aStringMilliSec size )					
					}
]

{ #category : #private }
SubtitleSRT >> newDurationTimeString: aStringTime [

	aStringTime  at:9  put:$. . "sino se le cambia la ',' por '.' pierde los milliseconds"
	^(Time readFromString:aStringTime) asDuration.
]

{ #category : #public }
SubtitleSRT >> printSubtitle [
	"convierte todo el sub en String con los saltos de linea ( stringLF )"
	^( 	self printTimeSTRFormat, 
		self stringLF,
		self text 
	).
]

{ #category : #private }
SubtitleSRT >> printTimeSTRFormat [
	" 00:00:03,878 --> 00:00:05,130  "
	"convierte el tiempoInit y fin en String format SRT "
	
	^'{1} --> {2}' format: {self printTimeSTRFormat:(self timeIni) . self printTimeSTRFormat:(self timeFin) }.
]

{ #category : #private }
SubtitleSRT >> printTimeSTRFormat:aTime [
	" 00:00:03,878 "
	"convierte el tiempoIni y fin en String format SRT "
	
	^'{1}:{2}:{3},{4}' format: {  
											self digitFormat: ( aTime hours ).
											self digitFormat: ( aTime minutes ).
											self digitFormat: ( aTime seconds ).
											self milliSecFormat:(aTime asMilliSeconds ) 
										}.
]

{ #category : #private }
SubtitleSRT >> readTimeFin:aStringTime [

		self timeFin: ( self newDurationTimeString: aStringTime ).
]

{ #category : #private }
SubtitleSRT >> readTimeIni:aStringTime [

		self timeIni: ( self newDurationTimeString: aStringTime ).
]

{ #category : #private }
SubtitleSRT >> readTimeString:aStringTime [
		"  '00:00:00,625 --> 00:00:03,837' aStringTime format "
		
	self readTimeIni:( (aStringTime splitOn:' --> ')at:1). 
	self readTimeFin:( (aStringTime splitOn:' --> ')at:2).
]

{ #category : #private }
SubtitleSRT >> stringLF [
	"devuelve el salto de linea en un String para poder concatenarlo"
	
	^String with: Character lf.
]

{ #category : #initalize }
SubtitleSRT >> text [ 
	^text.
]

{ #category : #initalize }
SubtitleSRT >> text:aString [
	
	text:=aString.
]

{ #category : #initalize }
SubtitleSRT >> timeFin [ 

	^timeFin.
]

{ #category : #initalize }
SubtitleSRT >> timeFin:aDuration [ 

	timeFin:=aDuration.
]

{ #category : #initalize }
SubtitleSRT >> timeIni [

	^timeIni.
]

{ #category : #initalize }
SubtitleSRT >> timeIni:aDuration [

	^timeIni:=aDuration.
]

{ #category : #public }
SubtitleSRT >> validateTime [
	
	^self timeIni < self timeFin.
]
