1.  summary Description of OWL axiomatization of phenotypes

Introduction
============

By encoding phenotypes in OWL we can leverage reasoners to automatically
construct and verify ontologies, and we can use the axioms to connect
data across different OBO library ontologies.

The motivation and background for the OWL axiomatization of phenotypes
can be found in:

C J Mungall, Georgios Gkoutos, Cynthia Smith, Melissa Haendel, Suzanna
Lewis, Michael Ashburner (2010) [Integrating phenotype ontologies across
multiple species](http://genomebiology.com/2010/11/1/R2) \_Genome
Biology 11 (1)\_

The essence of the axiomatization is that a subset of phenotypes are
assigned equivalence axioms to a class expression whose signature
includes a [PATO] class (the Quality, or "Q") and one or more classes
from OBO library ontologies (the Entity, or "E").

Phenotype Model
===============

The model we use was originally described in [Representing phenotypes in
OWL <http://ceur-ws.org/Vol-258/paper29.pdf>]. We are currently using a
slight variation of this model (the "subquality" model, such that all
phenotypes are defined as

With variants on this pattern for more complex phenotypes that do not
fit a simple EQ pattern.

This differs from the original pattern in that we enclose all
descriptions in a "has\_part" expression. This is to be consistent with
phenotype ontologies in which the subclass hierarchy does not follow the
PATO hierarchy

Modeling Patterns
=================

The modeling patterns we use are described on the PATO wiki:

<http://obofoundry.org/wiki/index.php/PATO:XP_Best_Practice>

TODO - update this documentation / bring it over here

Alternate models
================

The existing model we use is not set in stone. A number of other
promising models have been proposed, such as the 'phene' model, as
described in:

Hoehndorf, Robert, Anika Oellrich, and Dietrich Rebholz-Schuhmann.
[Interoperability between phenotype and anatomy
ontologies](http://bioinformatics.oxfordjournals.org/content/26/24/3112.short)
Bioinformatics 26.24 (2010): 3112-3118.

Our choice of model has been influenced by many practical factors,
including ease of authoring using standard tools and speed of reasoning.

Ease of authoring
-----------------

Historically we have authored the axioms in obo format, which has
imposed severe practical limits of expressivity, and the existing simple
pattern comes in part from this constraint. However, even as we move
into directly authoring the axioms in OWL, we want to keep the axioms
simple enough that a non-logician can understand and use them whilst
still using standard OWL environments such as Protege

Reasoner speed
--------------

The resulting combined ontology set we reasoner over can be large, so it
is important we use fast reasoners such as Elk. We therefore avoid using
constructs such as OWL cardinality, and instead use PATO classes to
define absence, duplication etc. It appears we do not lose anything by
going this route.
