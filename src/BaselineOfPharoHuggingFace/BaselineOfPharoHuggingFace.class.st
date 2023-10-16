Class {
	#name : #BaselineOfPharoHuggingFace,
	#superclass : #Object,
	#category : #BaselineOfPharoHuggingFace
}

{ #category : #baselines }
BaselineOfPharoHuggingFace >> baseline: spec [

	<baseline>
	spec for: #common do: [
		self defineDependencies: spec.
		self definePackages: spec.
		self defineGroups: spec ]
]

{ #category : #baselines }
BaselineOfPharoHuggingFace >> defineDependencies: spec [

	
]

{ #category : #baselines }
BaselineOfPharoHuggingFace >> defineGroups: spec [
]

{ #category : #baselines }
BaselineOfPharoHuggingFace >> definePackages: spec [

	spec package: 'Pharo-HuggingFace'
]
