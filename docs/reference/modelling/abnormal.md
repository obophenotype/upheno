1.  summary How inference of abnormality works

Introduction
============

The current design patterns are such that the abnormal qualifier is only
added when the quality class in the definition is neutral.

However, we still need to be able to infer

`* Hyoplasia of right ventricle SubClassOf Abnormality of right ventricle`

Because the latter class definition includes qualifier some abnormal,
the SubClassOf axiom will not be entailed unless the qualifier is
explicitly stated or inferred

Details
=======

We achieve this by including an axiom to PATO such that decreased sizes
etc are inferred to be qualifier some abnormal.

We do this with an exiom in imports/extra.owl

`* 'deviation(from normal)' SubClassOf qualifier some abnormal`

Anything under 'increased', 'decreased' etc in PATO is pre-reasoned in
PATO to be here.

See the following explanation:

<http://phenotype-ontologies.googlecode.com/svn/trunk/doc/images/has-qualifier-inference.png>

Limitations
===========

For this strategy to work it requires the PATO classes themselves to be
classified under deviation from normal. This may not always be the case

Notes
=====

Do not be distracted by the fact the has-qualifier relation is named
has-component at the moment

<https://code.google.com/p/phenotype-ontologies/issues/detail?id=45>

Notes
=====
