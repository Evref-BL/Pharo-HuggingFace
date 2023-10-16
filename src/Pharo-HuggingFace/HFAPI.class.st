Class {
	#name : #HFAPI,
	#superclass : #Object,
	#instVars : [
		'apiKey',
		'model'
	],
	#classInstVars : [
		'apiKey',
		'defaultModel'
	],
	#category : #'Pharo-HuggingFace'
}

{ #category : #accessing }
HFAPI class >> apiKey [

	^ apiKey
]

{ #category : #accessing }
HFAPI class >> apiKey: anObject [

	apiKey := anObject
]

{ #category : #accessing }
HFAPI class >> defaultModel [

	^ defaultModel
]

{ #category : #accessing }
HFAPI class >> defaultModel: anObject [

	defaultModel := anObject
]

{ #category : #accessing }
HFAPI class >> huggingFaceSettings: aBuilder [

	<systemsettings>
	(aBuilder group: #HuggingFace)
		parent: #tools;
		with: [
			(aBuilder setting: #apiKey)
				order: -100000;
				label: 'HuggingFace API Key';
				target: self;
				default: '';
				ghostHelp: 'My key'.
			(aBuilder setting: #defaultModel)
				order: -100000;
				label: 'HuggingFace Default model';
				target: self;
				default: 'Mistral-7B-Instruct-v0.1';
				ghostHelp: 'Model name' ]
]

{ #category : #accessing }
HFAPI >> apiKey [

	^ apiKey
]

{ #category : #accessing }
HFAPI >> apiKey: anObject [

	apiKey := anObject
]

{ #category : #accessing }
HFAPI >> initialize [

	super initialize.
	self apiKey: self class apiKey.
	self model: self class defaultModel
]

{ #category : #accessing }
HFAPI >> model [

	^ model
]

{ #category : #accessing }
HFAPI >> model: anObject [

	model := anObject
]

{ #category : #accessing }
HFAPI >> query: aTextQuery [

	| znClient command |
	znClient := ZnEasy client.
	znClient https.
	znClient forJsonREST.
	znClient headerAt: #Authorization put: 'Bearer ' , self apiKey.
	znClient host: 'api-inference.huggingface.co'.
	znClient path: '/models/mistralai/' , self model.
	command := '[INST]' , aTextQuery , '[/INST]'.
	znClient entity: (ZnEntity json:
			 (NeoJSONWriter toString: { (#inputs -> command) } asDictionary)).
	^ (znClient post anyOne at: #generated_text) allButFirst:
		  command size
]
