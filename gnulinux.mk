BACKUP := $(HOME)/backup.ab
export
$(HOME)/bin:
	mkdir $@
	[[ $(PATH) == *$@* ]] || echo Must add $@ to $$PATH >&2
$(HOME)/bin/apktool: scripts/linux/apktool
	cp $< $@
$(HOME)/bin/apktool.jar: brut.apktool/apktool-cli/build/libs/apktool-cli-all.jar
	cp $< $@
brut.apktool/apktool-cli/build/libs/apktool-cli-all.jar:
	./gradlew build shadowJar proguard release
$(BACKUP):
	adb backup -apk -all
$(BACKUP:.ab=): $(BACKUP)
	mkdir $@
	cd $@ && dd if=$< bs=24 skip=1 | openssl zlib -d | tar xvf -
