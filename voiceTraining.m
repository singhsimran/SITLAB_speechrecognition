clear all
close all
clc

%% Creating a recorder object
recorder = audiorecorder(16000, 8, 2); % 16000 Hz, 8 bits, 2 channels

%% Record the user's voice for 5s
disp("Please say something.")
drawnow(); % update figures and process callbacks
pause(1) % pauses for 1s
recordblocking(recorder, 5); % records the audio to recorder object for 5s.

%% Play the user's voice
play(recorder); % plays the audio from the recorder object
data = getaudiodata(recorder); % data is stored in a 8000 x 2 matrix.
plot(data); % plots the data
xlabel("Frequency") 
ylabel("Normalized values between -1 to 1")
title("Audio sample")

%% Feature Extraction
f = voiceFeatures(data);

%% Save the user database

user = input("Enter the user number: ");
try
    load database
    F = [F; f];
    C = [C; user];
    save database
catch 
    F = f;
    C = user;
    save database F C
end

msgbox("Voice registered!")