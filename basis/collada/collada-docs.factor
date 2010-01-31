! Copyright (C) 2010 Erik Charlebois
! See http://factorcode.org/license.txt for BSD license.
USING: help.markup help.crossref help.stylesheet help.topics help.syntax
definitions io prettyprint summary arrays math sequences vocabs strings
see xml.data hashtables ;
IN: collada

ABOUT: "collada"

ARTICLE: "collada" "Conversion of COLLADA assets"
"The " { $vocab-link "collada" } " vocabulary implements words for converting COLLADA assets to data suitable for use with OpenGL. See the COLLADA documentation at " { $url "http://collada.org" } "." ;

HELP: model
{ $class-description "Tuple of a packed attribute buffer, index buffer and vertex format suitable for a single OpenGL draw call." } ;

HELP: source
{ $class-description "Tuple of a vertex attribute semantic, offset in triangle index buffer and float data for a single vertex attribute." } ;

HELP: up-axis
{ $description "Dynamically-scoped variable with the up axis of the tags being read." } ;

HELP: unit-ratio
{ $description "Scaling ratio for the coordinates of the tags being read." } ;

HELP: missing-attr
{ $description "An error thrown when an attribute is missing from a tag." } ;

HELP: missing-child
{ $description "An error thrown when a child is missing from a tag." } ;

HELP: string>numbers ( string -- number-seq )
{ $values { "string" string } { "number-seq" sequence } }
{ $description "Splits a string on whitespace and converts the elements to a number sequence" } ;

HELP: x-up { $class-description "Right-handed 3D coordinate system where X is up." } ;
HELP: y-up { $class-description "Right-handed 3D coordinate system where Y is up." } ;
HELP: z-up { $class-description "Right-handed 3D coordinate system where Z is up." } ;

HELP: >y-up-axis!
{ $values { "sequence" sequence } { "from-axis" rh-up } { "sequence" sequence } }
{ $description "Destructively swizzles the first three elements of the input sequence to a right-handed 3D coordinate system where Y is up and returns the modified sequence." } ;

HELP: source>seq
{ $values { "source-tag" tag } { "up-axis" rh-up } { "scale" number } { "sequence" sequence } }
{ $description "Convert the " { $emphasis "float_array" } " in a " { $emphasis "source tag" } " to a sequence of number sequences according to the element stride. The values are scaled according to " { $emphasis "scale" } " and swizzled from " { $emphasis "up-axis" } " so that the Y coordinate points up." } ;

HELP: source>pair
{ $values { "source-tag" tag } { "pair" pair } }
{ $description "Convert the source tag to an id and number sequence pair." } ;

HELP: mesh>sources
{ $values { "mesh-tag" tag } { "hashtable" pair } }
{ $description "Convert the mesh tag's source elements to a hashtable from id to number sequence." } ;

HELP: mesh>vertices
{ $values { "mesh-tag" tag } { "pair" pair } }
{ $description "Convert the mesh tag's vertices element to a pair for further lookup in " { $link collect-sources } ". " } ;

HELP: collect-sources
{ $values { "sources" hashtable } { "vertices" pair } { "inputs" tag sequence } { "soures" sequence } }
{ $description "Look up the sources for these " { $emphasis "input" } " elements and return a sequence of " { $link source } " tuples." } ;

HELP: group-indices
{ $values { "index-stride" number } { "triangle-count" number } { indices "sequence" } { "grouped-indices" sequence } }
{ $description "Groups the index sequence by triangle and then groups each triangle's indices by vertex." } ;

HELP: triangles>numbers
{ $values { "triangles-tag" tag } { "number-seq" sequence } }
{ $description "Converts the triangle data in a triangles tag from string form to a sequence of numbers." } ;

HELP: largest-offset+1
{ $values { "source-seq" sequence } { "largest-offset+1" number } }
{ $description "Finds the largest offset in the sequence of " { $link source } " tuples and adds 1, which is the index stride for " { $link group-indices } "." } ;

HELP: <model>
{ $values { "attribute-buffer" sequence } { "index-buffer" sequence } { "sources" sequence } { "model" model } }
{ $description "Converts the inputs to a form suitable for use with " { $vocab-link "gpu" } " and constructs a " { $link model } "." } ;

HELP: soa>aos
{ $values { "triangles-indices" sequence } { "sources" sequence } { "attribute-buffer" sequence } { "index-buffer" sequence } }
{ $description "Swizzles the input sources from a structure of arrays form to an array of structures form and generates a new index buffer." } ;

HELP: triangles>model
{ $values { "sources" sequence } { "vertices" pair } { "triangles-tag" tag } { "model" model } }
{ $description "Creates a " { $link model } " tuple from the given triangles tag, source set and vertices pair." } ;

HELP: mesh>triangles
{ $values { "souces" sequence } { "vertices" pair } { "mesh-tag" tag } { "models" sequence } }
{ $description "Creates a sequence of models from the triangles in the mesh tag." } ;

HELP: mesh>models
{ $values { "mesh-tag" tag } { "models" sequence } }
{ $description "Converts a triangle mesh to a set of models suitable for rendering with OpenGL." } ;