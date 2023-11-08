Class {
	#name : #HFAPI,
	#superclass : #Object,
	#instVars : [
		'apiKey',
		'model',
		'return_full_text',
		'max_new_tokens',
		'max_time',
		'temperature',
		'num_return_sequences'
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
			(aBuilder pickOne: #defaultModel)
				order: -100000;
				label: 'HuggingFace Default model';
				target: self;
				default: HFCodeLlama34bInstructModel;
				domainValues: HFModel withAllSubclasses;
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
	self model: self class defaultModel new
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

{ #category : #accessing }
HFAPI >> num_return_sequences [

	^ num_return_sequences
]

{ #category : #accessing }
HFAPI >> num_return_sequences: anObject [

	num_return_sequences := anObject
]

{ #category : #api }
HFAPI >> query: aTextQuery [

	| znClient command paramDic result |
	znClient := ZnEasy client.
	znClient https.
	znClient forJsonREST.
	znClient headerAt: #Authorization put: 'Bearer ' , self apiKey.
	znClient host: 'api-inference.huggingface.co'.
	znClient path: '/models/' , self model name.
	command := Dictionary new.
	command at: #inputs put: (self model buildQuery: aTextQuery).
	paramDic := command at: #parameters put: Dictionary new.
	self return_full_text ifNotNil: [ :val |
		paramDic at: #return_full_text put: val ].
	self max_new_tokens ifNotNil: [ :val |
		paramDic at: #max_new_tokens put: val ].
	self max_time ifNotNil: [ :val | paramDic at: #max_time put: val asFloat ].
	self temperature ifNotNil: [ :val |
		paramDic at: #temperature put: val ].
	self num_return_sequences ifNotNil: [ :val |
		paramDic at: #num_return_sequences put: val ].

	znClient entity: (ZnEntity json: (NeoJSONWriter toString: command)).
	result := znClient post.
	result isArray ifFalse: [
		result
			at: #error
			ifPresent: [ :err | HFAPIError signal: err ]
			ifAbsent: [ self error: 'To improve' ] ].
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

{ #category : #accessing }
HFAPI >> temperature [

	^ temperature
]

{ #category : #accessing }
HFAPI >> temperature: anObject [

	temperature := anObject
]
