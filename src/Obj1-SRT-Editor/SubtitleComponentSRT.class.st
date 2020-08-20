"
superclase abstracta que tiene el protocolo para los componentes subtitlos.
implementa  pattern Component.

subClases que lo implementan SubtitleSRT, SubtitleDecoratorPlaneSRT.
"
Class {
	#name : #SubtitleComponentSRT,
	#superclass : #Object,
	#category : #'Obj1-SRT-Editor'
}

{ #category : #public }
SubtitleComponentSRT >> advanceTime:aDuration [
	
	self subclassResponsibility.
]

{ #category : #public }
SubtitleComponentSRT >> backTime:aDuration [
	
	self subclassResponsibility.
]

{ #category : #public }
SubtitleComponentSRT >> printSubtitle [
	"convierte todo el sub en String con los saltos de linea ( stringLF )"
	
	self subclassResponsibility.
]

{ #category : #public }
SubtitleComponentSRT >> validateTime [
	"controla que el timpo final sea mayor al tiempo inicio"
	self subclassResponsibility.
]
