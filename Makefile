all:

	g++ compout/compareroot.cpp -o compout/compareroot `root-config --libs --cflags`

clean:

	rm compout/compareroot