import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mathx_android/widgets/equationcard.dart';
import 'package:mathx_android/widgets/nestedtabbar.dart';
import 'package:mathx_android/widgets/shapescalculatorgeometricalshapepage.dart';

// TODO: Fix and clean up all null-safety ternary operator expressions in the cards

class ShapesCalculatorPage extends StatelessWidget {
  ShapesCalculatorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              title: const Text("Shapes Calculator"),
              bottom: const TabBar(
                tabs: [
                  Tab(
                    child: Text("2D"),
                  ),
                  Tab(
                    child: Text("3D"),
                  )
                ],
              )),
          body: const TabBarView(children: [
            NestedTabBar(
              "2D",
              children: {
                "Rectangle": buildRectangle(),
                "Triangle": buildTriangle(),
                "Circle": buildCircle(),
                "Trapezium": buildTrapezium(),
                "Parallelogram": buildParallelogram(),
              },
            ),
            NestedTabBar(
              "3D",
              children: {
                "Cuboid": buildCuboid(),
                "Pyramid": buildPyramid(),
                "Sphere": buildSphere(),
                "Cylinder": buildCylinder(),
                "Cone": buildCone(),
              },
            )
          ]),
        ));
  }
}

class buildRectangle extends StatelessWidget {
  const buildRectangle({super.key});

  @override
  Widget build(BuildContext context) {
    return GeometricalShapeTab(
        entries: const ["Length (l)", "Breadth (b)"],
        builder: (values, isFormValid) {
          return EquationCard(
              text:
                  "A = ${values[0] == "" || values[0] == null ? "l" : values[0]} * ${values.last == "" || values.last == null ? "b" : values.last} ${(values.length == 2 && isFormValid) ? "= ${values.map((e) => int.parse(e!)).reduce((value, element) => value * element)}" : ""}");
        });
  }
}

class buildTriangle extends StatelessWidget {
  const buildTriangle({super.key});

  @override
  Widget build(BuildContext context) {
    return GeometricalShapeTab(
        entries: const ["Length (l)", "Breadth (b)"],
        builder: (values, isFormValid) {
          return EquationCard(
            text: r"A = \frac 1 2 * "
                "${(values[0] ?? "") == "" ? "l" : values[0]} * ${values.last == "" || values.length == 1 ? "b" : values.last}${(values.length == 2 && isFormValid) ? "= ${values.map((e) => int.parse(e!)).reduce((value, element) => value * element) * 0.10}" : ""}",
          );
        });
  }
}

class buildCircle extends StatelessWidget {
  const buildCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return GeometricalShapeTab(
        entries: const ["Radius (r)"],
        builder: (values, isFormValid) {
          return EquationCard(
            text: r"A = \pi * "
                "${values[0] == "" ? "r^2" : "${values[0]}^2"}"
                "${values[0] != "" ? int.tryParse(values[0]!) != null ? "= ${pow(int.tryParse(values[0]!)!, 2) * pi}" : "= ERROR" : ""}",
          );
        });
  }
}

class buildTrapezium extends StatelessWidget {
  const buildTrapezium({super.key});
  @override
  Widget build(BuildContext context) {
    return GeometricalShapeTab(
        entries: const ["Base (a)", "Base (b)", "Height (h)"],
        builder: (values, isFormValid) {
          return EquationCard(
            text: r"A = \frac"
                " {${(values[0] ?? "") == "" ? "a" : values[0]}+${(values.elementAtOrNull(1) ?? "") == "" ? "b" : values[1]}}"
                "{2}*"
                "${(values.elementAtOrNull(2) ?? "") == "" ? "h" : values[2]}"
                "${(values.length == 3 && isFormValid) ? "= ${(int.parse(values[0]!) + int.parse(values[1]!)) / 2 * int.parse(values[2]!)}" : ""}",
          );
        });
  }
}

class buildParallelogram extends StatelessWidget {
  const buildParallelogram({super.key});

  @override
  Widget build(BuildContext context) {
    return GeometricalShapeTab(
        entries: const ["Length (a)", "Height (h)"],
        builder: (values, isFormValid) {
          return EquationCard(
            text:
                "A = ${(values[0] ?? "") == "" ? "l" : values[0]} * ${values.last == "" || values.length == 1 ? "b" : values.last}${(values.length == 2 && isFormValid) ? "= ${values.map((e) => int.parse(e!)).reduce((value, element) => value * element)}" : ""}",
          );
        });
  }
}

class buildCuboid extends StatelessWidget {
  const buildCuboid({super.key});

  @override
  Widget build(BuildContext context) {
    return GeometricalShapeTab(
        entries: const ["Length (l)", "Breadth (b)", "Height (h)"],
        builder: (values, isFormValid) {
          values = values
              .map((e) => e ?? "")
              .toList(); // To aid conversion from null to ""

          final l = (values[0]) == "" ? "l" : values[0];
          final b = (values[1]) == "" ? "b" : values[1];
          final h = (values[2]) == "" ? "h" : values[2];
          final volume = isFormValid
              ? int.parse(values[0]!) *
                  int.parse(values[1]!) *
                  int.parse(values[2]!)
              : null;
          final surfaceArea = isFormValid
              ? 2 * int.parse(values[0]!) * int.parse(values[1]!) +
                  2 * int.parse(values[1]!) * int.parse(values[2]!) +
                  2 * int.parse(values[0]!) * int.parse(values[2]!)
              : null;

          return Column(
            children: [
              EquationCard(
                  labelText: "Volume",
                  text: "V = "
                      "$l"
                      " * "
                      "$b"
                      " * "
                      "$h "
                      "${(volume != null) ? " = $volume" : ""}"),
              EquationCard(
                labelText: "Surface Area",
                text: "A = "
                    "2($l)($b)"
                    " + "
                    "2($l)($h)"
                    " + "
                    "2($b)($h)"
                    "${(surfaceArea != null) ? " = $surfaceArea" : ""}",
              ),
            ],
          );
        });
  }
}

class buildPyramid extends StatelessWidget {
  const buildPyramid({super.key});

  @override
  Widget build(BuildContext context) {
    return GeometricalShapeTab(
        entries: const ["Base Length (l)", "Base Breadth (b)", "Height (h)"],
        builder: (values, isFormValid) {
          values = values
              .map((e) => e ?? "")
              .toList(); // To aid conversion from null to ""

          final l = (values[0]) == "" ? "l" : values[0];
          final b = (values[1]) == "" ? "b" : values[1];
          final h = (values[2]) == "" ? "h" : values[2];

          final intL = num.tryParse(values[0]!);
          final intB = num.tryParse(values[
              1]!); // Converts all the above values to numbers for calculation
          final intH = num.tryParse(values[2]!);

          final volume = isFormValid ? (intL! * intB! * intH!) / 3 : null;

          // get the surface area of a right rectangular pyramid
          final surfaceArea = isFormValid
              ? (intL! * intB! +
                  (intL * (sqrt(pow(intB / 2, 2) + pow(intH!, 2)))) +
                  (intB * (sqrt(pow(intL / 2, 2) + pow(intH, 2)))))
              : null;

          return Column(
            children: [
              EquationCard(
                labelText: "Volume",
                text: r"V = \frac{"
                    "$l"
                    "*"
                    "$b"
                    "*"
                    "$h"
                    "}{3}"
                    "${(volume != null) ? " = $volume" : ""}",
              ),
              EquationCard(
                labelText: "Surface Area",
                text:
                    "A = $l($b)+$l(\\sqrt{(\\frac{$b}{2})^2 + $h^2} )+ $b(\\sqrt{(\\frac{$l}{2})^2+$h^2})"
                    "${(surfaceArea != null) ? " = $surfaceArea" : ""}",
              ),
            ],
          );
        });
  }
}

class buildSphere extends StatelessWidget {
  const buildSphere({super.key});

  @override
  Widget build(BuildContext context) {
    return GeometricalShapeTab(
        entries: const ["Radius (r)"],
        builder: (values, isFormValid) {
          values = values
              .map((e) => e ?? "")
              .toList(); // To aid conversion from null to ""

          return EquationCard(
            text: r"V = \frac{4}{3} * \pi * "
                "${values[0] == "" ? "r^3" : "${values[0]}^2"}"
                "${values[0] != "" ? int.tryParse(values[0]!) != null ? "= ${pow(int.tryParse(values[0]!)!, 3) * pi * 4 / 3}" : "= ERROR" : ""}",
          );
        });
  }
}

class buildCylinder extends StatelessWidget {
  const buildCylinder({super.key});

  @override
  Widget build(BuildContext context) {
    return GeometricalShapeTab(
        entries: const ["Radius (r)", "Height (h)"],
        builder: (values, isFormValid) {
          values = values
              .map((e) => e ?? "")
              .toList(); // To aid conversion from null to ""

          return EquationCard(
            text: r"V = \pi * "
                "${values[0] == "" ? "r^2" : "${values[0]}^2"}"
                "*"
                "${values.elementAtOrNull(1) == "" || values.length < 2 ? "h" : values.elementAt(1)}"
                "${values[0] != "" && values.elementAtOrNull(1) != "" ? int.tryParse(values[0]!) != null ? "= ${pow(int.tryParse(values[0]!)!, 2) * pi}" : "= ERROR" : ""}",
          );
        });
  }
}

class buildCone extends StatelessWidget {
  const buildCone({super.key});

  @override
  Widget build(BuildContext context) {
    return GeometricalShapeTab(
        entries: const ["Radius (r)", "Height (h)"],
        builder: (values, isFormValid) {
          values = values
              .map((e) => e ?? "")
              .toList(); // To aid conversion from null to ""

          return EquationCard(
            text: r"V = \pi * "
                "${values[0] == "" ? "r^2" : "${values[0]}^2"}"
                "* "
                r"\frac"
                "{${values.elementAtOrNull(1) == "" || values.length < 2 ? "h" : values.elementAt(1)}}{3}"
                "${values[0] != "" && values.elementAtOrNull(1) != "" && values.elementAtOrNull(1) != null ? int.tryParse(values[0]!) != null ? "= ${pow(int.tryParse(values[0]!)!, 2) * pi * (int.tryParse(values[1]!)! / 3)}" : "= ERROR" : ""}",
          );
        });
  }
}
