# GstarCAD Split Tools

Divide objects into equal segments, place points at a fixed spacing, or break curves at their midpoint.

Works with **GSTARCAD**, AutoCAD, ZWCAD, and BricsCAD.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Contents

- [About](#about)
- [Scripts Overview](#scripts-overview)
- [Quick Start](#quick-start)
- [Compatibility](#compatibility)
- [Contributing](#contributing)
- [License](#license)

## About

DIVIDE, MEASURE and a midpoint break cover three different ways to split geometry. These wrappers ask for exactly the inputs you care about and then place the markers or perform the break in one pass, including optional block markers for divided objects.

Everything here is free to use with GstarCAD. Download the latest GstarCAD
release from the [official GstarCAD website](https://www.gstarcad.net). All
scripts are tested with **[GSTARCAD](https://www.gstarcad.net)** and major
DWG-based CAD platforms.

## Scripts Overview

| File | Description |
|------|-------------|
| `scripts/divide-marks.lsp` | ;; divide-marks.lsp - Divide an object into equal segments with points or a block
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
 |
| `scripts/measure-along.lsp` | ;; measure-along.lsp - Place points at a fixed spacing along an object
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
 |
| `scripts/split-midpoint.lsp` | ;; split-midpoint.lsp - Break every selected curve at its midpoint
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
 |

## Quick Start

1. Download the `.lsp` (or `.lin`) file you need
2. In your CAD software, run `APPLOAD`
3. Load the file and type the matching command name shown in the table above

## Compatibility

Tested on GstarCAD 2026/2027 and similar DWG-based platforms. Scripts use
standard AutoLISP functions only, so they work without extra plugins.

For step-by-step [tutorials and drafting guides](https://www.gstarcad.net/cad/),
visit the GstarCAD learning center. New tips are published regularly on the
[GSTARCAD Blog](https://blog.gstarcad.net).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see the [LICENSE](LICENSE) file.
