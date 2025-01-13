
Project: Modeling and Verification of Railroad Controller system

The project involves modeling, simulation, and model checking in the popular software SPIN (see spinroot.com for all the details about the tool). The tool xspin has an easy-to-use interface (click on GettingStarted for instructions to run a demo of xspin). You need to get familiar with the tool by browsing through the manual, tutorial, and examples.

Here are a few notes to relate it to what we have discussed in the course.

Modeling
The modeling language is called Promela. The model consists of processes executing asynchronously and communicating by sending/receiving messages on channels. You will have to learn the syntax though. The directory Test contains many examples.

Simulation
You can either simulate or verify the model. In simulation mode, a single execution is generated, and illustrated using a format called Message Sequence Charts, a commonly used standardized notation from UML.

Specifying Requirements
You can insert assert statements within the model: if an assertion fails this is reported as an error. You can also write LTL formulas. SPIN compiles these formulas into what it calls never claims.

Model Checking
The basic verification algorithm in SPIN is enumerative depth-first-search. A large number of optimizations have been implemented to make it scale to complex models. Performance of the verifier crucially depends on setting of parameters.

Project Description
After learning the basics of the tool, you need to model and analyze the train controller described below.
 
![image](https://github.com/user-attachments/assets/6762de76-d070-4e8f-a4bc-1cc03abfe6c9)
 
Figure 1: Railroad controller Example

Figure 1 shows two circular railroad tracks, one for trains that travel clockwise and the other for trains that travel counterclockwise. At one place in the circle, there is a bridge that is not wide enough to accommodate both tracks. The two tracks merge on the bridge, and for controlling the access to the bridge, there is a signal at each entrance. If the signal at the western entrance is green, then a train coming from the west may enter the bridge, and if the signal is red, the train must wait. The signal at the eastern entrance to the bridge controls trains coming from the east in the same fashion.
![image](https://github.com/user-attachments/assets/6e3ea15f-be59-4566-84f1-b93f03a54fc1)

Figure 2: Modeling the Train as a Nondeterministic Reactive Component
 
A train is modeled by the component Train in Figure 2. The state of the train, captured by the enumerated variable mode, indicates whether the train is away from the bridge, waiting at the signal, or on the bridge. We use nondeterminism to model the assumption that the train can be away for an unknown period of time: when the train is away, either the state stays unchanged, or the train issues an output event with the value arrive and updates the state to waiting. When the train is waiting, it checks the signal. If the signal is red, then the train keeps waiting, and if the signal is green, then the train proceeds onto the bridge. The train can stay on the bridge for an arbitrary number of rounds. When the train exits from the bridge, it issues an output event with the value leave and updates the state to away.

The reactions of the train component can naturally be described using an extended-state machine with three modes corresponding to away, wait, and bridge. However, specifying the update as a single task would create an await dependency of the output event on the input signal. To avoid this, the component specification of Figure 2 splits the reaction description into two tasks. The first task A1 computes the value of the output variable out, and this does not depend on the input variable signal. The task A1 is nondeterministic: when the mode is away, the output can be absent or present with the value arrive; when the mode is wait, the output is absent; when the mode is bridge, the output can be either absent or present with the value leave. This description is captured by the single-mode extended-state machine in Figure 2. Recall that for a mode-switch, absence of a guard condition means that the mode-switch is always enabled (that is, by default, the guard condition is the constant 1 that is satisfied in every state), and absence of an associated update means that state variables do not change, and event outputs are absent. The second task A2 updates the mode based on the output computed by the task A1 and the value of the input signal. In the mode away, when the guard-condition out? arrive holds, the mode is updated to wait. The condition else on the self-loop is an abbreviation for the negated condition ¬(out ? arrive). In general, the guard condition else on a self-loop on a mode is satisfied exactly when none of the guard-conditions of the mode-switches out of this mode is satisfied. The mode- switches out of the modes wait and bridge are similar.
 
Since there are two trains, one traveling clockwise and the other traveling counterclockwise, we create two instances of the train component, TrainW and TrainE. We are asked to design a deterministic controller that prevents collisions between the two trains by ensuring that at all times, at most one train is on the bridge. More specifically, we want to design a deterministic synchronous reactive component Controller with input event variables outW and outE and with output variables signalW and signalE. When composed with the models of the trains, we get the composite system shown in Figure 3. Note that, irrespective of the await dependencies of the controller, there will be no cycles in await dependencies in these three components, and thus the above composition is well defined.

![image](https://github.com/user-attachments/assets/48ced2f4-912d-457c-84c0-968f42fda615)

Figure 3: Composite System for the Railroad Controller

The controller should be designed so that the property which is an invariant of RailRoadSystem. Here, the state variables modeW and mode are the state variables of the two instances of the train component. Example of train safety properties is

 
 
![image](https://github.com/user-attachments/assets/6d9e9f05-7b28-4b28-98eb-f7400b06f258)

Figure 4: Modeling of a safe controller for the Railroad Problem


Here is a list of what you should do for this project:
1.	Construct Promela model of the described a safe controller of a Railroad controller. Your model should be parameterized by the number of trains so that you can instantiate different configurations easily.
2.	For some specific configurations, simulate the model and observe its behavior (for example when there are two train are waiting at the bridge.)
3.	There is a monitor process proctype monitor in the code which can be used to ensure a safety property. You should use assertion to specify some other safety properties. Run the verifier to check that the model satisfies these specifications for the initial configuration.
 
You should submit (a) the Promela model of the controller constructed in part 1, (b) a brief explanation of what configuration and specific scenarios you simulated in part 2, and (c) the safety properties and result of verification in part 3.

Additional Files

TrainController2: Incomplete model written in Promela.
