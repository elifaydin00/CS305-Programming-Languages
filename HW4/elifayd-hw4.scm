(define check-length?
  (lambda (inTriple count)
    (= (length inTriple) count)))

(define check-sides?
  (lambda (inTriple)
    (and (integer? (car inTriple))
         (integer? (cadr inTriple))
         (integer? (caddr inTriple))
         (> (car inTriple) 0)
         (> (cadr inTriple) 0)
         (> (caddr inTriple) 0))))

(define check-triple?
  (lambda (tripleList)
    (cond ((null? tripleList) #t)
          ((not (list? (car tripleList))) #f)
          ((and (check-length? (car tripleList) 3)
                (check-sides? (car tripleList)))
           (check-triple? (cdr tripleList)))
          (else #f))))

(define sort-all-triples
  (lambda (tripleList)
    (map sort-triple tripleList)))

(define sort-triple
  (lambda (inTriple)
    (let ((sorted (sort inTriple <)))
      sorted)))

(define triangle?
  (lambda (triple)
    (let ((side1 (car triple))
          (side2 (cadr triple))
          (side3 (caddr triple)))
      (> (+ side1 side2) side3))))

(define filter-triangle
  (lambda (tripleList)
    (cond ((null? tripleList) '())
          ((triangle? (car tripleList))
           (cons (car tripleList) (filter-triangle (cdr tripleList))))
          (else (filter-triangle (cdr tripleList))))))

(define pythagorean-triangle?
  (lambda (triple)
    (= (+ (* (car triple) (car triple))
          (* (cadr triple) (cadr triple)))
       (* (caddr triple) (caddr triple)))))

(define filter-pythagorean
  (lambda (tripleList)
    (cond ((null? tripleList) '())                
          ((pythagorean-triangle? (car tripleList))
           (cons (car tripleList)
                 (filter-pythagorean (cdr tripleList))))   
          (else (filter-pythagorean (cdr tripleList)))))) 

(define get-area
  (lambda (triple)
    (let ((a (car triple))
          (b (cadr triple)))
      (/ (* a b) 2))))

(define sort-area
  (lambda (tripleList)
    (sort tripleList
          (lambda (triple1 triple2)
            (< (get-area triple1) (get-area triple2))))))

(define main-procedure
    (lambda (tripleList)
        (if (or (null? tripleList) (not (list? tripleList)))
            (error "ERROR305: the input should be a list full of triples")
            (if (check-triple? tripleList)
                (sort-area (filter-pythagorean (filter-triangle
                    (sort-all-triples tripleList))))
                (error "ERROR305: the input should be a list full of triples")
            )
        )
    )
)
