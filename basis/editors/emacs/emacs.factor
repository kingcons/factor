USING: definitions io.launcher kernel parser words sequences math
math.parser namespaces editors make system combinators.short-circuit
fry threads vocabs.loader ;
IN: editors.emacs

SYMBOL: emacsclient-path
SYMBOL: use-emacsclient

HOOK: default-emacsclient os ( -- path )

M: object default-emacsclient ( -- path ) "emacsclient" ;

: emacsclient ( file line -- )
    [
        {
            [ emacsclient-path get-global ]
            [ default-emacsclient dup emacsclient-path set-global ]
        } 0|| ,
        use-emacsclient get-global [ "--no-wait" , ] when
        number>string "+" prepend ,
        ,
    ] { } make
    os windows? [ run-detached drop ] [ try-process ] if ;

: emacs ( word -- )
    where first2 emacsclient ;

[ emacsclient ] edit-hook set-global

os windows? [ "editors.emacs.windows" require ] when
