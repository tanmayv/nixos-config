{config, pkgs, ...}: {


    boot = {
	
        kernelPackages = pkgs.lib.mkDefault (let
	 fedora-asus-kernel = {buildLinux, ...} @ args:
	   buildLinux (args
	    // rec {
	      version = "6.11.0";
	      extraMeta.branch = "6.11";
	      modDirVersion = version;

	      
	      src = pkgs.stdenv.mkDerivation rec {
		name = "linux-source";
		inherit version;

		# - [lukenukem/asus-kernel](https://copr.fedorainfracloud.org/coprs/lukenukem/asus-kernel/package/kernel/)
		# - [/results/lukenukem/asus-kernel/fedora-40-x86_64/07623253-kernel/](https://download.copr.fedorainfracloud.org/results/lukenukem/asus-kernel/fedora-40-x86_64/07623253-kernel/)
		# - [kernel build logs](https://download.copr.fedorainfracloud.org/results/lukenukem/asus-kernel/fedora-40-x86_64/07623253-kernel/builder-live.log.gz)
		src = builtins.fetchurl {
		  url = "https://download.copr.fedorainfracloud.org/results/lukenukem/asus-kernel/fedora-41-x86_64/08026916-kernel/kernel-6.11.0-666.rog.fc41.src.rpm";
		  sha256 = "sha256:1zs8shim3mc536j8jj9nman6g7mj2fpxn8ndcpmcdnm5y7jjqf4p";
		};

		phases = ["unpackPhase" "patchPhase"];
		unpackPhase = ''
		  ${pkgs.rpm}/bin/rpm2cpio $src | ${pkgs.cpio}/bin/cpio -idmv

		  mkdir $out
		  mv ./* $out
		  cd $out
		  tar -xf $out/linux-6.11.tar.xz --strip-components 1 -C $out/.
		'';

		patchPhase = ''
		  # apply all patches
		  # ${pkgs.fd}/bin/fd -t f -e patch . > ./patches.txt
		  patch -p1 -F50 < ./patch-6.11-redhat.patch
		  patches=$(grep "^ApplyOptionalPatch " ./kernel.spec | grep -v "{patchversion}" | cut -d " " -f2)
		  for patch in $patches; do
		    patch -p1 -F50 < ./$patch
		  done

		  # ./Makefile.rhelver is not included in the kernel.dev package. so make sure it is not needed at all
		  # inject RHEL stuff directly into the makefile
		  cd $out
		  var1="# Set RHEL variables"
		  TOTAL_LINES=`cat ./Makefile | wc -l`
		  BEGIN_LINE=`grep -n -e "$var1" ./Makefile | cut -d : -f 1`
		  BEGIN_LINE=$(($BEGIN_LINE - 1))
		  TAIL_LINES=$(($TOTAL_LINES - $BEGIN_LINE - 11))

		  head -n $BEGIN_LINE ./Makefile > ./Makefile2
		  cat ./Makefile.rhelver >> ./Makefile2
		  tail -n $TAIL_LINES ./Makefile >> ./Makefile2
		  mv ./Makefile2 ./Makefile
		'';
	      };
	      kernelPatches = [];
	      # kernelPatches = map (x: {
	      #     name = x;
	      #     patch = "${src}/${x}";
	      # }) [
	      #   # patches are listed in rpm package kernel.spec
	      #   # - [kernel.spec](https://copr-dist-git.fedorainfracloud.org/cgit/lukenukem/asus-kernel/kernel.git/tree/kernel.spec?id=5af4c495d3fb0cfed91e457308be4598ba4af95a#n1830)
	      #   # "patch-6.9-redhat.patch"
	      #   # ...
	      # ];
	      # kernelPatches = let
	      #   names = pkgs.lib.strings.split "\n" (builtins.readFile "${fedora-40-asus-kernel-source}/patches.txt");
	      #   filtered-names = pkgs.lib.lists.filter (e: ! (e == "" || e == [])) names;
	      #   patches = map (x: {
	      #     name = x;
	      #     patch = "${src}/${x}";
	      #   }) filtered-names;
	      # in patches;
	    
	    } // (args.argsOverride or {}));
	    linux_g14 = pkgs.callPackage fedora-asus-kernel {};
	   in
	    pkgs.recurseIntoAttrs (pkgs.linuxPackagesFor linux_g14));
			
	

	kernelParams = [  "amdgpu.dcdebugmask=0x10" ];
	    
	kernel.sysctl."vm.max_map_count" = 2147483642;
    

	blacklistedKernelModules = [ "nouveau" ];
    };

}


