"
clase abstracta que implementa Decorator Pattern
			y protocolo de SubtitleComponenetSRT.
	
	requiere de una implementacion concreta de SubtitleComponentSRT ""ejemplo SubtitleSRT"" para inicializar variable en el constructor
	
	ejemplo de constructor
	
		-newSubtitleDecoratorSRT newSubtitleDecorator: aSubtitleComponent.
		
	
"
Class {
	#name : #SubtitleDecoratorSRT,
	#superclass : #SubtitleComponentSRT,
	#instVars : [
		'component'
	],
	#category : #'Obj1-SRT-Editor'
}

{ #category : #constructor }
SubtitleDecoratorSRT class >> newSubtitleDecorator: aSubtitleComponent [

	^self new component: aSubtitleComponent.
]

{ #category : #public }
SubtitleDecoratorSRT >> advanceTime:aDuration [
	
	self subclassResponsibility.
]

{ #category : #public }
SubtitleDecoratorSRT >> backTime:aDuration [
	
	self subclassResponsibility.
]

{ #category : #initialize }
SubtitleDecoratorSRT >> component [

	^component.
]

{ #category : #initialize }
SubtitleDecoratorSRT >> component:aSubtitleComponent [

	component:=aSubtitleComponent.
]

{ #category : #initialize }
SubtitleDecoratorSRT >> initialize [ 
	super initialize.
]

{ #category : #public }
SubtitleDecoratorSRT >> printSubtitle [
	"convierte todo el sub en String con los saltos de linea ( stringLF )"
	
	self subclassResponsibility.
]

{ #category : #public }
SubtitleDecoratorSRT >> validateTime [
	"controla que el timpo final sea mayor al tiempo inicio"
	self subclassResponsibility.
]
