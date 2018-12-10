{:user
 {:plugins [
      ;[lein-ancient "0.6.5"]
            ;[lein-plz "0.4.0-SNAPSHOT" :exclusions [[rewrite-clj] [ancient-clj]]]

	    [lein-cljfmt "0.6.1"]

            [lein-kibit "0.1.6-beta2"]
            [lein-bikeshed "0.5.0"]
            [venantius/yagni "0.1.4"]
            [jonase/eastwood "0.2.5"]

            ;[lein-ns-dep-graph "0.2.0-SNAPSHOT"]
            [lein-hiera "0.9.5"]
            ; [lein-gossip "0.1.0-SNAPSHOT"]

            [lein-try "0.4.3"]
            [com.cemerick/drawbridge "0.0.7"]
      ;[com.cemerick/drawbridge "0.1.0-SNAPSHOT"]

            [lein-instant-cheatsheet "2.2.1"]]


  :aliases {"lint"
            ["do" ["kibit"] ["eastwood"] ["bikeshed"] ["yagni"]]

            "var-graph"
            ["with-profile" "+clj-usage-graph" "run"
             "-m" "com.gfredericks.clj-usage-graph/var-graph"]

            "namespace-graph"
            ["with-profile" "+clj-usage-graph" "run"
             "-m" "com.gfredericks.clj-usage-graph/namespace-graph"]}}

 ;; separate profile so that we only have these deps when we're
 ;; actually using clj-usage-graph
 :clj-usage-graph
 {:dependencies [[com.gfredericks/clj-usage-graph "0.3.0"]]}

 :repl {:plugins [[cider/cider-nrepl "0.10.0-SNAPSHOT"]
                  [refactor-nrepl "2.0.0-SNAPSHOT"]]
        :dependencies [[alembic "0.3.2"]
                       [org.clojure/tools.nrepl "0.2.12"]]}}
