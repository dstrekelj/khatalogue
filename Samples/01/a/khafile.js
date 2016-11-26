let project = new Project('Khatalogue - 01a');
project.addAssets('Assets/**');
project.addSources('Sources');
project.windowOptions = {
	width: 640,
	height: 240
};
resolve(project);
