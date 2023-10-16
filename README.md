# Pharo-HuggingFace

This is a simple API to call the inference API of [Hugging Face](https://huggingface.co).

## Example

**First**, change your api key in the Pharo settings

```st
api := HFAPI new.
api query: 'How are you ?'.
```

## Installation

```st
Metacello new
  githubUser: 'Evref-BL' project: 'Pharo-HuggingFace' commitish: 'main' path: 'src';
  baseline: 'PharoHuggingFace';
  load
```
