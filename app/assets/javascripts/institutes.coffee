jQuery ->
	if gon?
		test = {"name":"Bernhard Inc","children":[{"name":"carmela@littel.biz","size":9},{"name":"constance@ebertcrona.biz","size":10},{"name":"Farrell-Hilpert","children":[{"name":"garrett_haley@mccullough.biz","size":11},{"name":"buford_windler@jaskolski.org","size":13},{"name":"lorine@will.info","size":11},{"name":"joannie@jakubowskiemmerich.org","size":9},{"name":"shayna@marquardtreinger.biz","size":8},{"name":"ova@quitzonmann.info","size":11}]},{"name":"McCullough LLC","children":[{"name":"te_rodriguez@schroederbrekke.name","size":7},{"name":"bret@zulauf.info","size":11},{"name":"garnet.bailey@blockbruen.org","size":8},{"name":"kyra@wehner.info","size":8}]},{"name":"Kerluke-Gutmann","children":[{"name":"trea.mann@veumkerluke.org","size":7},{"name":"isabella_lowe@mueller.info","size":9},{"name":"davon_adams@sengerzulauf.org","size":8},{"name":"magdalena@schuppe.com","size":11},{"name":"kenton@prosaccowisozk.biz","size":6}]},{"name":"Breitenberg, Jaskolski and Hamill","children":[{"name":"gabriel_douglas@boyle.info","size":8},{"name":"raul.graham@considineemard.info","size":10},{"name":"reagan@bradtke.biz","size":7},{"name":"jeromy.prohaska@stantonblick.com","size":8},{"name":"marco_moriette@jakubowskilockman.info","size":7},{"name":"osborne.oconner@zemlak.org","size":9}]},{"name":"Strosin-Bartell","children":[{"name":"josiane.lynch@ferry.biz","size":8},{"name":"barton@lowekertzmann.name","size":9},{"name":"christian_lubowitz@howe.com","size":6},{"name":"juvenal.medhurst@schoen.info","size":6},{"name":"maximus_simonis@parker.com","size":8},{"name":"dawn@predovicvolkman.net","size":13},{"name":"toney@oconnellullrich.name","size":9}]}]}
		myFlower = new CodeFlower("#visualization", 200, 200)
		myFlower.update(gon.institute)

		console.log gon.institute