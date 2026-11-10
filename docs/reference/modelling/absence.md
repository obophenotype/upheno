1.  summary Discussion of issues pertaining to modeling of absence in
    phenotype ontologies

Introduction
============

Much has been written on the subject of representing absence. Before
diving into the logical issues it is worth examining patterns in
existing phenotype ontologies to understand what user expectations may
typically be for absence.

Background
==========

`* `[`Absence_Phenotypes_in_OWL`](http://phenoscape.org/wiki/Absence_Phenotypes_in_OWL)` (Phenoscape Wiki)`\
`* (outdated) material on the old `[`PATO`
`wiki`](http://obofoundry.org/wiki/index.php/PATO:Revised_2008#Absence_and_counting)`.`

Details
=======

Strict logical absence vs absence of some
-----------------------------------------

It is not uncommon to see patterns such as

From a strict logical perspective, this is inverted. "absent incisors"
surely means "absence of all incisors", or put another way "the animal
has no incisors". Yet it would be possible to have an animal with
\*absent\* lower incisors and \*present\* upper incisors, yielding what
seems a contradiction (because the subClass axiom would say this
partial-incisor animal lacked all incisors).

If the ontology were in fact truly modeling "absence of \*all\* S" then
it would lead to a curious ontology structure, with the typical tree
structure of the anatomy ontology representing S inverted into a
polyhierarchical fan in the absent-S ontology.

From this it can be cautiously inferred that the intent of the phenotype
ontology curator and user is in fact to model "absence of \*some\* S"
rather than "absence of \*all\* S". This is not necessarily a universal
rule, and the intent may vary depending on whether we are talking about
a serially repeated structure or one that typically occurs in isolation.
The intent may also be to communicate that a \*significant number\* of S
is missing.

Absence as a type of morphology
-------------------------------

It is also not uncommon to see patterns such as:

Again, from a strict logical perspective this is false. If the spleen is
absent then what does the "morphology" of the parent refer to?

However, this inference is clearly a desirable one from the point of
view of the phenotype ontology editors and users, as it is common in
ontologies for a variety of structures. For example:

And:

These patterns can be formally defended on developmental biology
grounds. "absence" here is \_not\_ equivalent to logical absence. It
refers specifically to developmental absence.

Furthermore, strict logical absence leads to undesirable inferences. It
would be odd to include a nematode worm as having the phenotype "spleen
absent", because worms have not evolved spleens. But the logical
description of not having a spleen as part fets a worm.

Similarly, if the strict cardinality interpretation were intended, we
would expect to see:

i.e. if you're missing your entire hindlegs, you're \*necessarily\*
missing your femurs. But it must be emphatisized that this is \*not\*
how phenotype ontologies are classified. This goes for a wide range of
structures and other relationship types. In MP, "absent limb buds" are
\*not\* classified under "absent limbs", even though it is impossible
for a mammal to have limbs without having had limb buds.

### Absence as part of a size-morphology spectrum

The existing treatment of absence can be formally defended
morphologically by conceiving of a morphological value space, with
"large" at one end and "small" at the other. As we get continuously
smaller, there may come an arbitrary point whereby we say "surely this
is no longer a limb" (and of course, we are not talking about a pure
geometrical size transformation here - as a limb reaches extreme edges
of a size range various other morphological changes necessarily happen).
But this cutoff is arguably arbitrary, and the resulting discontinuity
causes problems. It is simpler to treat absence as being one end of a
size scale.

Summary
-------

This is barely touching the subject, and is intended to illustrate that
things may be more subtle than naively treating words like "absent" as
precisely equivalent to cardinality=0. An understanding of the medical,
developmental and evolutionary contexts are absolutely required,
together with an understanding of the entailments of different logical
formulations.

Even though existing phenotype ontologies may not be conceived of
formally, it is implicit than they do not model absence as being
equivalent to cardinality=0 / not(has\_part), because the structure of
these ontologies would look radically different.

TODO
----

Link to Jim Balhoff's PhenoDay paper and discussion

Here's the link: <http://phenoday2014.bio-lark.org/pdf/11.pdf>
