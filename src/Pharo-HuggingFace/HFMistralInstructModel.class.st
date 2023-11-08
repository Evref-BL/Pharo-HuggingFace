Class {
	#name : #HFMistralInstructModel,
	#superclass : #HFModel,
	#category : #'Pharo-HuggingFace'
}

{ #category : #'as yet unclassified' }
HFMistralInstructModel >> buildQuery: aTextQuery [

	^ '[INST] ' , aTextQuery , ' [/INST]'
]

{ #category : #'as yet unclassified' }
HFMistralInstructModel >> name [

	^ 'mistralai/Mistral-7B-Instruct-v0.1'
]
