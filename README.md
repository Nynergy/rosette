# rosette

_rosette_ is a CLI program written in Haskell that players of the Traveller
TTRPG can use when preparing for/playing the game. The name comes from the idea
of [rosette worlds](https://wiki.travellerrpg.com/Rosette_World), which exist in
the Third Imperium universe of Traveller.

At the moment, the program can parse [UWP
codes](https://campaignwiki.org/traveller/edit) which are often used by random
generators, game referees, and other automated tools when making and maintaining
user-created worlds/sectors. The list of UWPs are contained in a plaintext file
passed to _rosette_ on the command line.

In the future, I'd like to add this kind of generation to _rosette_, so that it
can be used as an all-in-one tool to create an arbitrary amount of worlds, save
them to a file, display their information, and allow referees to add
descriptions, story information, and other metadata to their created worlds.

The point of _rosette_ is not to become a richly-featured tool, however. It is
meant to facilitate the creation, management, and display of user-created
worlds, but the low-level detail of stories, adventures, characters, etc, is
left up to the discretion of the referee. That, in my opinion, is the beauty of
the Traveller world creation system; the imagination is far more powerful than
any computer program. _rosette_ will take care of all the minutae, while you
handle the fun bits.

---------------------------------------------------------------------------------

## Installation

Use `cabal` to build and install _rosette_. Also be sure your `~/.cabal/bin`
folder (or other relevant install directory) is part of your `$PATH`.

```
git clone https://github.com/Nynergy/rosette.git
cd rosette
cabal build
cabal install
```

---------------------------------------------------------------------------------

## Usage

_rosette_ requires your UWP codes be stored in a plaintext file. My personal
convention is to put them in a '.sec' file, like the one below, which I named
`example.sec`:

```
Inedgeus     0101 D7A5579-8        G  Fl Ni          A
Geaan        0102 E66A999-7        G  Hi Wa          A
Orgemaso     0103 C555875-5       SG  Ga Lt
Veesso       0105 C5A0369-8        G  De Lo          A
Ticezale     0106 B769799-7    T  SG  Ri             A
Maatonte     0107 C6B3544-8   C    G  Fl Ni          A
Diesra       0109 D510522-8       SG  Ni
Esarra       0204 E869100-8        G  Lo             A
Rience       0205 C687267-8        G  Ga Lo
Rearreso     0208 C655432-5   C    G  Ga Lt Ni
Laisbe       0210 E354663-3           Ag Lt Ni
Biveer       0302 C646576-9   C    G  Ag Ga Ni
Labeveri     0303 A796100-9   CT N G  Ga Lo          A
Sotexe       0408 E544778-3        G  Ag Ga Lt       A
Zamala       0409 A544658-13   T N G  Ag Ga Ht Ni
Sogeeran     0502 A200443-14  CT N G  Ht Ni Va
Aanbi        0503 E697102-7        G  Ga Lo          A
Bemaat       0504 C643384-9   C R  G  Lo Po
Diare        0505 A254430-11   TRN G  Ni             A
Esgeed       0507 A8B1579-11    RN G  Fl Ni          A
Leonbi       0510 B365789-9    T  SG  Ag Ri          A
Reisbeon     0604 C561526-8     R  G  Ni
Atcevein     0605 A231313-11  CT   G  Lo Po
Usmabe       0607 A540A84-15   T   G  De Hi Ht In Po
Onbebior     0608 B220530-10       G  De Ni Po       A
Raraxema     0609 B421768-8    T NSG  Na Po
Xeerri       0610 C210862-9        G  Na
Onreon       0702 D8838A9-2       S   Lt Ri          A
Ismave       0703 E272654-4           Lt Ni
Lara         0704 C0008D9-5       SG  As Lt Na Va    A
Lalala       0705 C140473-9     R  G  De Ni Po
Maxereis     0707 A55A747-12  CT NSG  Ht Wa
Requbire     0802 C9B4200-10       G  Fl Lo          A
Azaxe        0804 B6746B9-8   C    G  Ag Ga Ni       A
Rieddige     0805 B355578-7        G  Ag Ni          A
Usorce       0806 E736110-3        G  Lo Lt          A
Solacexe     0810 D342635-4  P    S   Lt Ni Po       R
```

To use this sector file, just invoke _rosette_ in the following way:

`rosette example.sec`

_rosette_ will then parse the codes in the file and present the user with a list
of systems in the sector. Input the number of the desired system and its
information will be printed to the terminal in a very nice layered/cascading
list.
