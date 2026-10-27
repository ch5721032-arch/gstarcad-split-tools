;; divide-marks.lsp - Divide an object into equal segments with points or a block
;; Command: DIVMARK
(defun c:DIVMARK ( / en n blk )
  (setq en (car (entsel "\nSelect object to divide: ")))
  (if en
    (progn
      (setq n (getint "\nNumber of segments <2>: "))
      (if (null n) (setq n 2))
      (setq blk (getstring "\nBlock name for markers (Enter for points): "))
      (if (= blk "")
        (command "_.DIVIDE" en n)
        (command "_.DIVIDE" en n blk "_Y")
      )
      (princ "\nDone.")
    )
  )
  (princ)
)
