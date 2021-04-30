# 🚀 KSP KOS Scripts 👩‍🚀👨🏽‍🚀

Just uploading my scripts so I don't lose them. Maybe I'll write some documentation later.

File structure:

- [/boot]: This is where the bootloaders live for a given rocket. If a connection is present, it connects with KSC, downloads and bundles all the required scripts for a given program and then executes the program.
- [/lib]: This is a bunch of reusable code modules that can be used to compose larger scripts.
- [/src]: This is where the primary scripts lib, right now there is a basic hover script and a script that launches and circularizes.
- [/bin]: This is where compiled kOS scripts are stored

See [/notes.md](/notes.md) for additional notes and resources.


## Resources

- [Wiki: Terminology](https://wiki.kerbalspaceprogram.com/wiki/Terminology)
- [Wiki: Cheat Sheet](https://wiki.kerbalspaceprogram.com/wiki/Cheat_sheet)
- [Wiki: Gravity Turn](https://wiki.kerbalspaceprogram.com/wiki/Gravity_turn)
- [Wiki: Atmosphere](https://wiki.kerbalspaceprogram.com/wiki/Atmosphere)
- [Wiki: basic Orbiting](https://wiki.kerbalspaceprogram.com/wiki/Tutorial:_Basic_Orbiting_(Math))
- [Wiki: Advanced Orbiting](https://wiki.kerbalspaceprogram.com/wiki/Tutorial:_Advanced_Orbiting)
- [First Point of Aries](https://en.wikipedia.org/wiki/First_Point_of_Aries)
- [https://en.wikipedia.org/wiki/Lambert%27s_problem]

### Burn Time:

- [Tsiolkovsky Rocket Equation](https://en.wikipedia.org/wiki/Tsiolkovsky_rocket_equation)
- [Tsiolkovsky's rocket equation](https://canmom.github.io/physics/rocket-equation#information-staging)
- [Burn Time](https://www.reddit.com/r/Kos/comments/3ftcwk/compute_burn_time_with_calculus/)

### KOS

- [KOS](https://ksp-kos.github.io/KOS/contents.html)
- [KOS: How do I use libs](https://www.reddit.com/r/Kos/comments/43wgoc/how_do_i_use_libraries/)
- [KOS: How do I achieve a more circular orbit](https://www.reddit.com/r/KerbalSpaceProgram/comments/2c2bo5/how_can_i_achieve_a_more_circular_orbit/)
- [KOS: Gradient Descent](https://www.reddit.com/r/Kos/comments/bg7qlz/gradient_descent_is_finding_unusual_solution/)
- [KOS: Visavis](https://www.reddit.com/r/Kos/comments/azr17q/how_can_you_calculate_the_circularisation_burn/)
- [What is the easiest way to circularize](https://www.reddit.com/r/Kos/comments/2wuo9o/what_is_the_easiest_way_to_circularize_while/)


### Transfers & Burns

- [Braeunig: Orbital Mechanics](http://www.braeunig.us/space/orbmech.htm)
- [Braeunig: Interplanetary Flight](http://www.braeunig.us/space/interpl.htm)
- [Launch Window Planer](https://alexmoon.github.io/ksp/)
- [Interactive illustrated interplanetary guide and calculator for KSP](https://ksp.olex.biz/)
- [[Tutorial] Interplanetary How-To Guide](https://forum.kerbalspaceprogram.com/index.php?/topic/16413-tutorial-interplanetary-how-to-guide/)
- [[PDF] Interplanetary How-To Guide](/resources/interplanetary_how_to_guide.pdf)
- [Reddit: How do I calculate phase and ejection angle](https://www.reddit.com/r/KerbalAcademy/comments/35wtv1/how_do_i_calculate_phase_and_ejection_angle/cr8pu4j/)
- [Lambert's Problem](https://en.wikipedia.org/wiki/Lambert%27s_problem)

## License

- MIT, Seee [LICENSE](/LICENSE) for more details.
