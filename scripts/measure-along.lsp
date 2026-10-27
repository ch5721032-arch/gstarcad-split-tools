;; measure-along.lsp - Place points at a fixed spacing along an object
;; Command: MEASL
(defun c:MEASL ( / en d )
  (setq en (car (entsel "\nSelect object to measure: ")))
  (if en
    (progn
      (setq d (getreal "\nSegment length <10>: "))
      (if (null d) (setq d 10.0))
      (command "_.MEASURE" en d "")
      (princ "\nDone.")
    )
  )
  (princ)
)
