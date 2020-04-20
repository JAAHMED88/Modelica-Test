within ;
package FluidExamples

  model Example1 "Simplest possible model"
    extends Modelica.Icons.Example;
    package water = Modelica.Media.Water.ConstantPropertyLiquidWater;

    Modelica.Fluid.Pipes.StaticPipe pipe(redeclare package Medium = water,
      length=20,
      diameter=1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Modelica.Fluid.Sources.FixedBoundary boundary1(
      redeclare package Medium = water,
      nPorts=1,
      p=200000,
      T=293.15)
      annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
    inner Modelica.Fluid.System system
      annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
    Modelica.Fluid.Sources.FixedBoundary boundary2(
      redeclare package Medium = water,
      nPorts=1,
      p=100000,
      T=293.15)
      annotation (Placement(transformation(extent={{82,-10},{62,10}})));
  equation
    connect(boundary1.ports[1], pipe.port_a)
      annotation (Line(points={{-60,0},{-10,0}}, color={0,127,255}));
    connect(pipe.port_b, boundary2.ports[1])
      annotation (Line(points={{10,0},{62,0}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      uses(Modelica(version="3.2.2")),
      experiment(StopTime=100, __Dymola_NumberOfIntervals=2000),
                Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Example1;

  model Example2 "Minimalist pipe network"
    extends Modelica.Icons.Example;
    package water = Modelica.Media.Water.ConstantPropertyLiquidWater;

    Modelica.Fluid.Pipes.StaticPipe pipe1(
      redeclare package Medium = water,
      length=20,
      diameter=1)
      annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
    Modelica.Fluid.Sources.FixedBoundary boundary1(
      redeclare package Medium = water,
      nPorts=1,
      p=200000,
      T=293.15)
      annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
    inner Modelica.Fluid.System system
      annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
    Modelica.Fluid.Sources.FixedBoundary boundary2(
      redeclare package Medium = water,
      p=100000,
      T=293.15,
      nPorts= 3)
      annotation (Placement(transformation(extent={{82,-10},{62,10}})));
    Modelica.Fluid.Pipes.StaticPipe pipe2(
      redeclare package Medium = water,
      length=20,
      diameter=1) annotation (Placement(transformation(extent={{10,30},{30,50}})));
    Modelica.Fluid.Pipes.StaticPipe pipe3(
      redeclare package Medium = water,
      length=20,
      diameter=1.5)
      annotation (Placement(transformation(extent={{10,-50},{30,-30}})));
  
    Modelica.Fluid.Pipes.StaticPipe pipe4(
      redeclare package Medium = water,
      diameter= 1.25,
      length= 30)
      annotation (Placement(visible = true, transformation(extent = {{12, 60}, {32, 80}}, rotation = 0)));
  
  equation
    connect(boundary1.ports[1], pipe1.port_a)
      annotation (Line(points={{-60,0},{-40,0}}, color={0,127,255}));
    connect(pipe1.port_b, pipe2.port_a) annotation (Line(points={{-20,0},{0,0},{0,
            40},{10,40}}, color={0,127,255}));
    connect(pipe1.port_b, pipe3.port_a) annotation (Line(points={{-20,0},{0,0},{0,
            -40},{10,-40}}, color={0,127,255}));
    connect(pipe2.port_b, boundary2.ports[1]) annotation (Line(points={{30,40},{40,
            40},{40,2},{62,2}}, color={0,127,255}));
    connect(pipe3.port_b, boundary2.ports[2]) annotation (Line(points={{30,-40},{40,
            -40},{40,-2},{62,-2}}, color={0,127,255}));
  connect(pipe1.port_b, pipe4.port_a) annotation(
      Line(points = {{-20, 0}, {-9, 0}, {-9, 70}, {12, 70}}, color = {0, 127, 255}));
  connect(pipe4.port_b, boundary2.ports[3]) annotation(
      Line(points = {{32, 70}, {62, 70}, {62, 0}}, color = {0, 127, 255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      uses(Modelica(version="3.2.2")),
      experiment(StopTime=100, __Dymola_NumberOfIntervals=2000),
                Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Example2;
  annotation (uses(Modelica(version="3.2.2")));
end FluidExamples;
