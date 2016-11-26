let project = new Project('Khatalogue - 01d');
project.addAssets('Assets/**');
project.addSources('Sources');
project.windowOptions = {
	width: 640,
	height: 240
};
resolve(project);
