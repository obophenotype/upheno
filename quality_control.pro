xp_mismatch(P1,P2,X1,X2,Msgs) :-
        equivalent_class(P1,P2),class(P1),class(P2),
        class_cdef(P1,X1),
        class_cdef(P2,X2),
        setof(Msg,cdef_mismatch(X1,X2,Msg),Msgs).

cdef_mismatch(cdef(G1,_),cdef(G2,_),mismatched_genus) :-
        G1\=G2.
cdef_mismatch(cdef(G,D1),cdef(G,D2),Msg) :-
        maplist(umap,D1,D1x),
        maplist(umap,D2,D2x),
        diffs_mismatch(D1x,D2x,Msg).

diffs_mismatch(D1x,D2x,unique1(X)) :-
        member(_=X,D1x),
        \+ member(_=X,D2x).
diffs_mismatch(D1x,D2x,unique2(X)) :-
        member(_=X,D2x),
        \+ member(_=X,D1x).
diffs_mismatch(D1x,D2x,rel1(R)) :-
        member(R=X,D1x),
        \+ member(R=X,D2x),
        member(_=X,D2x).
diffs_mismatch(D1x,D2x,rel1(R)) :-
        member(R=X,D2x),
        \+ member(R=X,D1x),
        member(_=X,D1x).

/*
cdef_match(cdef(G,D1),cdef(G,D2),IsStrictRel) :-
        maplist(umap,D1,D1x),
        maplist(umap,D2,D2x),
        writeln(D2x),
        writeln(D2x),
        (   IsStrictRel=true
        ->  R1=R2
        ;   true),
        forall(member(R1=X,D1x),
               member(R2=X,D2x)),
        forall(member(R1=X,D2x),
               member(R2=X,D1x)).
*/

umap(R=X,R=Y) :- !,umap(X,Y).
umap(X,Y) :- entity_xref(Y,X),id_idspace(Y,'UBERON'),!.
umap(X,X).

               
