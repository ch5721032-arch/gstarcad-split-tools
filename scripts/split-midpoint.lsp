;; split-midpoint.lsp - Break every selected curve at its midpoint
;; Command: SPLITMID
(defun c:SPLITMID ( / ss i en len mid )
  (vl-load-com)
  (setq ss (ssget '((0 . "LINE,ARC,LWPOLYLINE,POLYLINE,SPLINE"))))
  (if ss
    (progn
      (setq i 0)
      (repeat (sslength ss)
        (setq en (ssname ss i))
        (setq len (vlax-curve-getDistAtParam en (vlax-curve-getEndParam en)))
        (if (and len (> len 0.0))
          (progn
            (setq mid (vlax-curve-getPointAtDist en (/ len 2.0)))
            (if mid (command "_.BREAK" en mid "@"))
          )
        )
        (setq i (1+ i))
      )
      (princ (strcat "\nProcessed " (itoa (sslength ss)) " objects."))
    )
    (princ "\nNothing selected.")
  )
  (princ)
)
