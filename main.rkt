#lang codespells

(require test-mod/mod-info)

(require-mod hierarchy)
(require-mod spawners)
(require-mod triggers)
(require-mod fire-particles)
(require-mod ice-particles)
(require-mod rocks)
(require-mod cabin-items)

(define my-mod-lang
  (append-rune-langs #:name main.rkt  
                     (hierarchy:my-mod-lang #:with-paren-runes? #t)
                     (spawners:my-mod-lang)
                     (triggers:my-mod-lang)
                     (fire-particles:my-mod-lang)
                     (ice-particles:my-mod-lang)
                     (rocks:my-mod-lang)
                     (cabin-items:my-mod-lang)
		     ))

(module+ main

  (codespells-workspace ;TODO: Change this to your local workspace if different
   (build-path (current-directory) ".." ".."))

  (thread
    (thunk
      (codespells-server-port 8998)
      (unreal-server-port 8999)
      (multiplayer 'server)
      (extra-unreal-command-line-args "-WinX=0 -WinY=50 -ResX=640 -ResY=480 -Windowed")

      (once-upon-a-time
	#:world (demo-world)
	#:aether (demo-aether
		   #:lang my-mod-lang))))


  (thread
    (thunk
      (codespells-server-port 7998)
      (unreal-server-port 7999)
      (multiplayer 'client)
      (extra-unreal-command-line-args "-WinX=640 -WinY=50 -ResX=640 -ResY=480  -Windowed")

      (once-upon-a-time
	#:world (demo-world)
	#:aether (demo-aether
		   #:lang my-mod-lang))))
  

  (sleep 10000)
  )
