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
f_test = voiceFeatures(data);

%% Find the closest feature from database.
load database
D = [];
for i = 1:size(F, 1)
    d = abs(F(i) - f_test);
    D = [D d];
end

%% Smallest distance
sm = inf;
ind = -1;
for i = 1:length(D)
    if D(i) < sm
        sm = D(i);
        ind = i;
    end
end

detected_class = C(ind);
disp('The detected class is ');
detected_class