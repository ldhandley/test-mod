#lang codespells

(require test-mod/mod-info
         (only-in racket/gui message-box get-text-from-user))

(require-mod hierarchy)
(require-mod spawners)
(require-mod triggers)
(require-mod fire-particles)
(require-mod ice-particles)
(require-mod rocks)
(require-mod sevarog)
(require-mod cabin-items)
(require-mod crystals)

(define my-mod-lang
  (append-rune-langs #:name main.rkt  
                     (hierarchy:my-mod-lang #:with-paren-runes? #t)
                     (crystals:my-mod-lang)
                     (fire-particles:my-mod-lang)
                     (ice-particles:my-mod-lang)
                     (rocks:my-mod-lang)
                     (sevarog:my-mod-lang)

		     ))


(module+ main
  (codespells-workspace ;TODO: Change this to your local workspace if different
   (build-path (current-directory) ".." "..")
   ;(build-path (current-directory))
   )

  (if (eq? (message-box "Multiplayer" "Do you want to run a CodeSpells server?" #f '(yes-no)) 'yes)
      (multiplayer 'server)
      (let ()
        (multiplayer 'client)
        (server-ip-address (get-text-from-user "Multiplayer" "IP Address:" #f "127.0.0.1")))
      )
  
  ;-WinX=0 -WinY=50 -ResX=640 -ResY=480 -Windowed 
  (extra-unreal-command-line-args "-AudioMixer -PixelStreamingIP=localhost -PixelStreamingPort=8888")
  
  (once-upon-a-time
   #:world (arena-world)
   #:aether (demo-aether
             #:lang my-mod-lang)))



#;
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
	#:world (arena-world)
	#:aether (demo-aether
		   #:lang my-mod-lang))))


  (thread
    (thunk
      (codespells-server-port 7998)
      (unreal-server-port 7999)
      (multiplayer 'client)
      (extra-unreal-command-line-args "-WinX=640 -WinY=50 -ResX=640 -ResY=480  -Windowed")

      (once-upon-a-time
	#:world (arena-world)
	#:aether (demo-aether
		   #:lang my-mod-lang))))
  

  (sleep 10000))
