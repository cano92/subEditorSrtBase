"
administra una Colleccion de Componentes que implentan SubtitleComponentSRT

	
	
"
Class {
	#name : #SubtitleManagerSRT,
	#superclass : #Object,
	#instVars : [
		'subtitleList',
		'fileManager'
	],
	#category : #'Obj1-SRT-Editor'
}

{ #category : #public }
SubtitleManagerSRT >> addSubtitle:aSubtitle [
	
	
	self subtitleList add:aSubtitle.
	self subtitlesSort.
]

{ #category : #public }
SubtitleManagerSRT >> advanceTime:aDuration [

	self subtitleList do: [:subtitle | subtitle advanceTime:aDuration  ]
]

{ #category : #public }
SubtitleManagerSRT >> backTime:aDuration [

	self subtitleList do: [:subtitle | subtitle backTime:aDuration. ]
]

{ #category : #initialize }
SubtitleManagerSRT >> fileManager [
	
	^fileManager.
]

{ #category : #initialize }
SubtitleManagerSRT >> fileManager:aFileManager [
	
	fileManager:=aFileManager.
]

{ #category : #public }
SubtitleManagerSRT >> findSubtitle:aIndex [

	^self subtitleList at:aIndex.
	
	
]

{ #category : #initialize }
SubtitleManagerSRT >> initialize [
	
	self subtitleList: OrderedCollection new.
	self fileManager: FileManagerSRT new.
]

{ #category : #validations }
SubtitleManagerSRT >> isOverlap:aSubtitlePrev next:aSubtitleNext [
	
	
	^(aSubtitlePrev timeFin) >= ( aSubtitleNext timeIni ). 
]

{ #category : #public }
SubtitleManagerSRT >> isSubtitlesOverlap [
	
	^( 2 to: (self subtitleList size)) detect:  
			[:index| self isOverlap:(self subtitleList at:(index -1))  next:(self subtitleList at:index) ]
		
	ifNone:[ false ].
]

{ #category : #public }
SubtitleManagerSRT >> openFile:aFileNameSRT [

	self subtitleList: (self fileManager loadFileSRT:aFileNameSRT ).
]

{ #category : #public }
SubtitleManagerSRT >> removeSubtitle:aSubtitle [

	self subtitleList remove: aSubtitle.
]

{ #category : #public }
SubtitleManagerSRT >> saveFile:aFileNameSRT [

	self fileManager writeFileSRT:(self subtitleList) on:aFileNameSRT
]

{ #category : #public }
SubtitleManagerSRT >> saveFilePlane:aFileNameSRT [

	self fileManager writeFileSRT:(self subtitleListPlane) on:aFileNameSRT
]

{ #category : #initialize }
SubtitleManagerSRT >> subtitleList [

	^subtitleList.
]

{ #category : #initialize }
SubtitleManagerSRT >> subtitleList:aListSubtitles [

	subtitleList:=aListSubtitles.
]

{ #category : #private }
SubtitleManagerSRT >> subtitleListPlane [
	
	^self subtitleList collect:	[:subtitle| SubtitleDecoratorPlaneSRT newSubtitleDecorator:subtitle ]. 
]

{ #category : #private }
SubtitleManagerSRT >> subtitlesSort [
	
	
	self subtitleList:( 
		self subtitleList asSortedCollection:[:subtitlePrev :subtitleNext | subtitlePrev timeIni <= subtitleNext timeIni  ] 
	).
]

{ #category : #public }
SubtitleManagerSRT >> updateSubtitle [

	self subtitlesSort.
	
	
]
