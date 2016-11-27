let project = new Project('Khatalogue - 01b');
project.addAssets('Assets/**');
project.addSources('Sources');
project.windowOptions = {
	width: 640,
	height: 240
};
project.targetOptions.html5 = {
	canvasId: 'khatalogue-01b',
	scriptName: 'khatalogue-01b'
};
resolve(project);
