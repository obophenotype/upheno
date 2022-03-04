# Add custom uPheno Makefile

The custom uPheno Makefile is an extension to your normal custom Makefile (for example, hp.Makefile, mp.Makefile, etc), located in the src/ontology directory of your ODK set up. 

To install it:

(1) Open your normal custom Makefile and add a line in the very end:

```
include pheno.Makefile
```

(2) Now download the custom Makefile:

https://raw.githubusercontent.com/obophenotype/upheno/master/src/ontology/config/pheno.Makefile

and save it in your `src/ontology` directory.

Feel free to use, for example, wget:

```
cd src/ontology
wget https://raw.githubusercontent.com/obophenotype/upheno/master/src/ontology/config/pheno.Makefile -O pheno.Makefile
```

From now on you can simply run


```
sh run.sh make update_pheno_makefile
```

whenever you wish to synchronise the Makefile with the uPheno repo.

(Note: it would probably be good to add a GitHub action that does that automatically.)