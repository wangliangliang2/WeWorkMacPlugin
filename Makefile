build-wework:
		xcodebuild  -project WeWorkMacPlugin.xcodeproj -scheme WeWorkMacPlugin -configuration Release  -destination 'platform=OS X,arch=x86_64' DSTROOT="${PWD}" archive
		bash install.sh '企业微信' WeWorkMacPlugin.framework
		
		