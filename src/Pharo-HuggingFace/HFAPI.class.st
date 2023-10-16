Class {
	#name : #HFAPI,
	#superclass : #Object,
	#instVars : [
		'apiKey',
		'model',
		'return_full_text',
		'max_new_tokens',
		'max_time'
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
HFAPI >> max_new_tokens [

	^ max_new_tokens
]

{ #category : #accessing }
HFAPI >> max_new_tokens: anObject [

	max_new_tokens := anObject
]

{ #category : #accessing }
HFAPI >> max_time [

	^ max_time
]

{ #category : #accessing }
HFAPI >> max_time: anObject [

	max_time := anObject
]

{ #category : #accessing }
HFAPI >> model [

	^ model
]

{ #category : #accessing }
HFAPI >> model: anObject [

	model := anObject
]

{ #category : #api }
HFAPI >> query: aTextQuery [

	| znClient command paramDic |
	znClient := ZnEasy client.
	znClient https.
	znClient forJsonREST.
	znClient headerAt: #Authorization put: 'Bearer ' , self apiKey.
	znClient host: 'api-inference.huggingface.co'.
	znClient path: '/models/mistralai/' , self model.
	command := Dictionary new.
	command at: #inputs put: '[INST]' , aTextQuery , '[/INST]'.
	paramDic := command at: #parameters put: Dictionary new.
	self return_full_text ifNotNil: [ :val |
		paramDic at: #return_full_text put: val ].
	self max_new_tokens ifNotNil: [ :val |
		paramDic at: #max_new_tokens put: val ].
	self max_time ifNotNil: [ :val | paramDic at: #max_time put: val ].

	znClient entity: (ZnEntity json: (NeoJSONWriter toString: command)).

	^ znClient post anyOne at: #generated_text
]

{ #category : #accessing }
HFAPI >> return_full_text [

	^ return_full_text
]

{ #category : #accessing }
HFAPI >> return_full_text: anObject [

	return_full_text := anObject
]
