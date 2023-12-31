Class {
	#name : #BaselineOfPharoHuggingFace,
	#superclass : #BaselineOf,
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

	spec
		baseline: 'NeoJSON'
		with: [ spec repository: 'github://svenvc/NeoJSON/repository' ]
]

{ #category : #baselines }
BaselineOfPharoHuggingFace >> defineGroups: spec [
]

{ #category : #baselines }
BaselineOfPharoHuggingFace >> definePackages: spec [

	spec
		package: 'Pharo-HuggingFace'
		with: [ spec requires: #( 'NeoJSON' ) ]
]
