! Copyright (C) 2006, 2007, 2008 Alex Chapman
! See http://factorcode.org/license.txt for BSD license.
USING: accessors arrays combinators kernel math math.vectors namespaces opengl opengl.gl sequences tetris.board tetris.game tetris.piece ui.render tetris.tetromino ui.gadgets ;
IN: tetris.gl

#! OpenGL rendering for tetris

: draw-block ( block -- )
    dup { 1 1 } v+ gl-fill-rect ;

: draw-piece-blocks ( piece -- )
    piece-blocks [ draw-block ] each ;

: draw-piece ( piece -- )
    dup tetromino>> colour>> set-color draw-piece-blocks ;

: draw-next-piece ( piece -- )
    dup tetromino>> colour>>
    clone 0.2 >>alpha set-color draw-piece-blocks ;

! TODO: move implementation specific stuff into tetris-board
: (draw-row) ( x y row -- )
    >r over r> nth dup
    [ set-color 2array draw-block ] [ 3drop ] if ;

: draw-row ( y row -- )
    dup length -rot [ (draw-row) ] 2curry each ;

: draw-board ( board -- )
    rows>> dup length swap
    [ dupd nth draw-row ] curry each ;

: scale-board ( width height board -- )
    [ width>> ] [ height>> ] bi swapd [ / ] dup 2bi* 1 glScalef ;

: (draw-tetris) ( width height tetris -- )
    #! width and height are in pixels
    GL_MODELVIEW [
        {
            [ board>> scale-board ]
            [ board>> draw-board ]
            [ next-piece draw-next-piece ]
            [ current-piece draw-piece ]
        } cleave
    ] do-matrix ;

: draw-tetris ( width height tetris -- )
    origin get [ (draw-tetris) ] with-translation ;