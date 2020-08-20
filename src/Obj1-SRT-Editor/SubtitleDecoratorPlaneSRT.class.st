"
clase concreta Decorador PlaneSRT implementa SubtitleDecoratorSRT
	
	funcionalidad extra agregada a los componentes SubtitleComponentSRT
		
		-elimina todos los Tags de estilo de los texto
			<b>ejemplo</b>  			=> ejemplo  
			{i #color }ejemplo{/i}	=> ejemplo
				
	hereda constructor decorador de SubtitleDecoratorSRT - requiere una implementacion SubtitleComponentSRT
	
	ejemplo
		newSubtitleDecoratorSRT newSubtitleDecorator: aSubtitleComponent.
"
Class {
	#name : #SubtitleDecoratorPlaneSRT,
	#superclass : #SubtitleDecoratorSRT,
	#category : #'Obj1-SRT-Editor'
}

{ #category : #public }
SubtitleDecoratorPlaneSRT >> advanceTime:aDuration [
	
	self component advanceTime:aDuration.
]

{ #category : #public }
SubtitleDecoratorPlaneSRT >> backTime:aDuration [
	
	self component backTime:aDuration.
]

{ #category : #public }
SubtitleDecoratorPlaneSRT >> printSubtitle [
	"agrega la funcionalidad extra de eliminar los tags"
	
	^self removeTagsSRT:(self component printSubtitle) on:( WriteStream on: (String new) ).
]

{ #category : #private }
SubtitleDecoratorPlaneSRT >> removeTagsSRT:aString on:aContens [
	"elimina todos los Tags SRT - del String recivido como parametro y los devuelve"
	|selector|
	selector:=true.
	
		aString do: [:char|  		
			( ( char = $< ) or: ( char = ${ ) )ifTrue:[ selector:=false  ].
			"si el selector es verdadero el texto no esta en Tags y lo agrega al String aContens" 
			(selector ) ifTrue: [ aContens nextPut:char ].
			( ( char = $> ) or: ( char = $} ) )ifTrue:[ selector:=true  ].
			].
		^aContens contents.
]

{ #category : #public }
SubtitleDecoratorPlaneSRT >> validateTime [
	"valida que el tiempo inicio sea menor al fin"
	
	^self component validateTime.
]
