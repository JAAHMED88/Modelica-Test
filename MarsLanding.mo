package MarsLanding
  model Marsplanet
    constant Real G = 6.672e-11;//Universal gravitational constant
    parameter Real radius;
    parameter String name;
    Real mass;
    Real ForceMars;
  end Marsplanet;

  //----------------------------------------------------

  model Rocket
    parameter String name;
    Real mass(start = 1038.358, fixed = true);//Initial Rocket's mass
    Real altitude(start = 59404, fixed = true);//Initial Rocket's altitude
    Real velocity(start = -2003, fixed = true);//Initial Rocket's velocity
    Real acceleration;
    Real thrust; // Thrust force on the rocket
    Real gravity;
    // Gravity forcefield
    parameter Real massLossRate = 0.000277;
  equation
    (thrust - mass * gravity) / mass = acceleration;
    der(mass) = -massLossRate * abs(thrust);
    der(altitude) = velocity;
    der(velocity) = acceleration;
  end Rocket;

  //----------------------------------------------------

  model MarsLanding
    parameter Real forceThrust = 36350;//Thrust in phase 1 (variable public)
    parameter Real forceMars = 3616.16;//Thrust in phase 2 (variable public)
    Rocket AtlasV(name = "AtlasV");
    Marsplanet Mars(name = "Mars", mass = 0.64171e24, radius = 3.3962e6);

    model F22
      parameter Real forceThrust = 16000;//Thrust in phase 1 (variable public)
      parameter Real F22 = 3616.16;//Thrust in phase 2 (variable public)
      Rocket AtlasV(name = "AtlasV");
      Marsplanet Mars(name = "Mars", mass = 0.64171e24, radius = 3.3962e6);
    protected
      parameter Real thrustEndTime = 120;//Global Time operation (variable protected)
      parameter Real thrustDecreaseTime = 43.2;//Time of the first phase (variable protected)
    equation
      AtlasV.thrust = if time < thrustDecreaseTime then forceThrust 
                      else if time < thrustEndTime then F22 
                      else 0;
      AtlasV.gravity = Mars.G * Mars.mass / (AtlasV.altitude + Mars.radius)^2;
    equation
      Mars.ForceMars = Mars.G * AtlasV.mass * Mars.mass / (AtlasV.altitude + Mars.radius) ^ 2;
    end F22;

    model F23
      parameter Real forceThrust = 46000;//Thrust in phase 1 (variable public)
      parameter Real F23 = 3616.16;//Thrust in phase 2 (variable public)
      Rocket AtlasV(name = "AtlasV");
      Marsplanet Mars(name = "Mars", mass = 0.64171e24, radius = 3.3962e6);
    
    protected
      parameter Real thrustEndTime = 120;//Global Time operation (variable protected)
      parameter Real thrustDecreaseTime = 43.2;//Time of the first phase (variable protected)
    equation
      AtlasV.thrust = if time < thrustDecreaseTime then forceThrust 
                      else if time < thrustEndTime then F23 
                      else 0;
      AtlasV.gravity = Mars.G * Mars.mass / (AtlasV.altitude + Mars.radius)^2;
    equation
      Mars.ForceMars = Mars.G * AtlasV.mass * Mars.mass / (AtlasV.altitude + Mars.radius) ^ 2;
    
    end F23;
  protected
    parameter Real thrustEndTime = 120;//Global Time operation (variable protected)
    parameter Real thrustDecreaseTime = 43.2;//Time of the first phase (variable protected)
  equation
    AtlasV.thrust = if time < thrustDecreaseTime then forceThrust 
                    else if time < thrustEndTime then forceMars 
                    else 0;
    AtlasV.gravity = Mars.G * Mars.mass / (AtlasV.altitude + Mars.radius)^2;
  equation
    Mars.ForceMars = Mars.G * AtlasV.mass * Mars.mass / (AtlasV.altitude + Mars.radius) ^ 2;
  end MarsLanding;
end MarsLanding;
