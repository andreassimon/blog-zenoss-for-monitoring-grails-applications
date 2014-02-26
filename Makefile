default:
	erubis blog-entry.md.erb | markdown > blog-entry.html

resize-screenshots:
	convert 1-zenoss-login.png         -resize 588x1024\> 1-zenoss-login.scaled.png
	convert 2-zenoss-dashboard.png     -resize 588x1024\> 2-zenoss-dashboard.scaled.png
	convert 3-zenoss-devices.png       -resize 588x1024\> 3-zenoss-devices.scaled.png
	convert 4-zenoss-add-devices.png   -resize 588x1024\> 4-zenoss-add-devices.scaled.png
	convert 5-zenoss-running-jobs.png  -resize 588x1024\> 5-zenoss-running-jobs.scaled.png
	convert 6-zenoss-graphs.png        -resize 588x1024\> 6-zenoss-graphs.scaled.png
