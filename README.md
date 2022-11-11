# Enhanced Containers

This is a collection of interface for the `List` and `Map` containers of Dart and Flutter.

# Table of contents

- [Enhanced Containers](#enhanced-containers)
- [Table of contents](#table-of-contents)
- [How to use the enhanced_containers package](#how-to-use-the-enhanced_containers-package)
  - [ItemSerializable](#itemserializable)
  - [The List](#the-list)
    - [ListSerializable](#listserializable)
    - [ListProvider](#listprovider)
    - [FirebaseListProvided](#firebaselistprovided)
  - [The Map](#the-map)
    - [MapSerializable](#mapserializable)
    - [MapProvided](#mapprovided)
    - [FirebaseMapProvided](#firebasemapprovided)
- [Examples](#examples)
- [How to contribute](#how-to-contribute)
  - [Enhancing enhancers](#enhancing-enhancers)
  - [More database](#more-database)
  - [Documentation](#documentation)
- [Cite](#cite)


# How to use the enhanced_containers package

An example is available that shows how the package is intended to be used.
In a nutshell, the `ListXxx` and `MapXxx` are to be used as normal `List` and `Map`. 
For instance, if one declares a `ListProvided`, then this `ListProvided` can be used as a normal `List` but will take care of the `notifyListeners()` stuff by itself. 

## ItemSerializable

This is the base item of any `enhanced_container`, i.e. if one wants to use any `enhanced_container`, the item must be a `ItemSerializable`. 

The requirements to declare a `ItemSerializable` is to provide the `serializeMap()` method that returns a dictionary of the item that should all be serialiazable (i.e. base types such `int`, `double`, `String`, etc. or another `ItemSerializable`). 

## The List

### ListSerializable

A `ListSerializable` is a `List` where the item can be serialized (i.e. are of types `ItemSerializable`). 
This is particularly useful if the `List` is sent to a database. 

The requirements to declare a `ListSerializable` is to provide a `ItemSerializable deserializeItem(data)` method which calls (or implements) the reverse process of `ItemSerializable.serializeMap()`. This method is automatically called when needed.

### ListProvider

A `ListProvider` is basically a `ListSerializable` but that calls `notifyListeners()`. 

### FirebaseListProvided

As probably suspected, a `FirebaseListProvided` is a `ListProvider` that calls the Firebase database and update the key by itself, while also acting as a provider. 

The requirements to construct a `FirebaseListProvided` is to declare a constructor with pahtToData as such: `FirebaseListOfMyRandomItem({required super.pathToData});`. Optionnally `pathToAvailableDataIds` can also be specified. By default, the `pathToAvailableDataIds` is the `pathToData` with `ids` appended. 

AvailableIds are a way to ensure one does not see the data from another user. 
For instance, if person1 adds data in the list and person2 adds data as well, all the data are stored in `pathToData` but only what is marked as available in `pathToAvailableDataIds` will be shown to person1 and person2 respectively.

## The Map

### MapSerializable

As for the `ListSerializable` the `MapSerializable` is basically a `Map` with `ItemSerializable`. 

The requirements to declare a `MapSerializable` is to provide a `ItemSerializable deserializeItem(data)` method which calls (or implements) the reverse process of `ItemSerializable.serializeMap()`. This method is automatically called when needed.

### MapProvided 

A `MapProvider` is basically a `MapSerializable` but that calls `notifyListeners()`. 

### FirebaseMapProvided

The is not `FirebaseMapProvided` available yet. If one needs it, they can wrap the `MapSerializable` in a `ListSerializable`. 

# Examples

An example can be found in the official Git repository [https://github.com/cr-crme/enhanced_containers/](https://github.com/cr-crme/enhanced_containers/).

This example can be used as template to construct your own `enhanced_containers`.

# How to contribute

## Enhancing enhancers

Not all the methods of the `List` and `Map` are currently implemented in their respective enhanced version. One can help by implementing those. 

## More database

Currently, there is only the Firebase interface database implemented, but there is no reason to only have them. Anyone who wants to help can implement more of them.

## Documentation

Please do not hesitate to correct or modify the documentation as better documentation means better usability!

# Cite

If used, please cite the package as such

```bibtex
@misc{
    MichaudEnhancedContainers2022, 
    author = {Michaud, Benjamin and Stephenne, Laurent}, 
    title = {Enhanced containers for Dart and Flutter}, 
    howpublished={Web page}, 
    url = {https://github.com/cr-crme/enhanced_containers}, 
    year = {2022} 
}
```
