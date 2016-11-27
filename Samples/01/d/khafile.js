let project = new Project('Khatalogue - 01d');
project.addAssets('Assets/**');
project.addSources('Sources');
project.windowOptions = {
	width: 640,
	height: 240
};
project.targetOptions.html5 = {
	canvasId: 'khatalogue-01d',
	scriptName: 'khatalogue-01d'
};
resolve(project);
