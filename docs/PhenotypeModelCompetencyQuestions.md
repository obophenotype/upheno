1.  summary Competency questions to test a schema/pattern for modeling
    phenotypes

<wiki:toc max_depth="4" />

Introduction
============

This is background material for discussion amongst OWL modelers
concerning the consequences of modeling choices.

Each competency question is stated in terms of an OWL axiom or axioms
that should be entailed, given the existence of supporting axioms in
external ontologies. This could be translated into a test suite (e.g.
using junit) to objectively test a given model.

examples are given in Manchester syntax. We assume prefixes of the form

Together with imports of relevant ontologies.

We take existing phenotype ontologies as a kind of "gold standard" and
assume that assertions provided are correct - of course it may be the
case that further discussion will lead to some existing patterns being
changed. However, this is expected to be unusual.

Details
=======

Core Competency Questions
-------------------------

The model \*must\* be able to derive the desired entailments here.

### CQ: Basic Inheritance using E class hierarchy

Example:

### CQ: Basic Inheritance using Q class hierarchy

Example:

Supporting axioms:

And:

### CQ: Basic Inheritance using E partonomy

Example:

Existing approaches:

The approach described in [Mungall et al
2010](http://genomebiology.com/2010/11/1/R2/#sec2) uses a new relation:

Then, assuming a basic Q-in-E model, we can write:

To obtain the desired inference (also works if the digit morphology term
is restricted to inheres\_in).

Informally, we can think of this in terms of a weaker relation that
permits propagation up the E partonomy (and subclass), and a stronger
relation that only propagates up subclass.

The main challenge here is deciding which qualities should be propagated
when. An abnormal morphology of a nucleus of a muscle cell of digit 1
would satisfy the condition, but this would be an undesirable inference.
To recapitulate the desired level of propagation will require a more
sophisticated approach.

### CQ: Basic Relational Quality Inference

...

Advanced Competency Questions
-----------------------------

Some of these may simply be too hard. Others may be controversial w.r.t
what the intended meaning of the phenotype is, and what the expected
entailment is.

### Absence Reasoning

Note that there are many subtleties here. Please read
[ModelingOfAbsence] as an introduction.

#### CQ: Strict Logical Absence

Example:

Please refer to [ModelingOfAbsence] see why the classes used in this
example may not be equivalent to any existing MP class or why inferences
of this sort may not be useful from a developmental phenotyping context.

We assume background axioms:

#### CQ: Absence of Some

Example:

Refer to [ModelingOfAbsence] for a discussion on why this is a desirable
inference.

#### CQ: absence classifies under morphology

Example:

#### CQ: absence classifies under decreased number

Example:

### Developmental Competency Questions

To see how MP is currently classified, see this example:

We could argue that the pattern should be switched here, and that
abnormal tooth morphology generally arises through abnormal tooth
development. However, it is of course possible for teeth to attain
abnormal morphology post-development.

Some of the justifications for the other relationships in the above
example are more subtle.

More input from biologists required to inform competency questions here.

#### CQ: development classifies under morphology

See above

#### CQ: morphology of developmental structure classifies under development

See above - this is somewhat inverted from the previous example:

See also: <https://github.com/obophenotype/uberon/issues/346>

### Traits

For our purposes here a trait is a phenotype without a value specified.
Various modeling choices can be justified.

#### CQ: Traits connect to phenotypes

Example:

Note 1: here 'hippocampus size' refers to the size of the hippocampus in
general. There is no assumption of abnormality

Note 2: other relationships beyond SubClassOf can be justified. However,
there should be \*some\* connection between trait and phenotype
ontologies (e.g. VT and MP) that can be inferred.

#### CQ: Traits are distinguishable

Example:

Notes on E-centric approach:

If we were to model traits as:

Then given the background axioms:

Then our two traits would collapse into (be entailed to be equivalent
to) 'eye' leading to unsatisfiability of eye when the DisjointWith is
added.

### Concentrations and populations

#### CQ: iron levels in spleen

Background: [Loebe et al](http://www.jbiomedsem.com/content/3/S2/S5)
JBMS

Both

And

See Also
========

`* `[`properties` `of` `phenotype` `ontology` `modeling`
`schemas`](https://docs.google.com/spreadsheet/ccc?key=0AskRPmmvPJU3dC1pcjE5X1Y0UFJwVG1QRWhYYjdSRFE#gid=0)
