# Video Recording app tutorial 
![GitHub License](https://img.shields.io/github/license/EngOmarElsayed/VideoRecordingApp)

## Table of Contents
1. [Introduction](#introduction)
   - [PreView of the app](#PreView)
3. [AVCapture](#section-1)
   - [AVCaptureInput](#sub-topic-1.1)
   - [AVCaptureSession](#sub-topic-1.2)
   - [AVCaptureOutput](#sub-topic-1.3)
4. [Implementation](#section-2)
   - [AVCapture Manger](#sub-topic-2.1)
   - [Camera Preview](#sub-topic-2.2)
   - [CameraViewModel](#sub-topic-2.3)
   - [CameraView](#sub-topic-2.4)
5. [Conclusion](#conclusion)
6. [Bouns](#bouns)
   - [AVCaptureDevice.ramp](#bouns-2.1)
   - [CameraViewModel.ZoomInOut](#bouns-2.2)
   - [ZoomGesture](#bouns-2.3)
   - [ZoomLabel](#bouns-2.4)
8. [Resourrces](#resourrces)
9. [Author](#author)

## Introduction <a name="introduction"></a>
Attention iOS developers, get ready to elevate your app-building skills to cinematic heights 😎! Welcome to a transformative journey where we'll unlock the full potential of the Capture API collection, empowering you to create custome camera app.

Why settle for ordinary when you can craft extraordinary? With a custom camera app, you wield the power to integrate cutting-edge features like barcode scanning, object detection, and immersive augmented reality (AR) filters, delivering unparalleled user engagement.

But that's just the beginning. Picture this: seamless user flow with profile picture capture integrated directly within your app, offering users an uninterrupted experience. Say goodbye to limitations – with granular control, you'll unlock functionalities amazing features, unleashing boundless creativity.

Interested ? Let's dive deeper 🚀. Discover how to harness the Power of Preview by seamlessly integrating a live camera feed directly into your app. Become a Video Maestro as you effortlessly start and stop video recording within your app, capturing moments with finesse. And fear not, saving those memories is a breeze – effortlessly store captured videos in the user's library, ensuring no moment is lost.

But wait, there's more! Master the art of zooming – in and out – to perfect every shot with our bonus feature.

By the end of this blog, you'll wield the Capture API like a seasoned pro, equipped to build custom camera apps that not only impress but leave a lasting impression. Stay tuned for the next section, where we'll unveil the secrets of using Capture API collection in your app!

## AVCapture <a name="section-1"></a>
The AVFoundation Capture subsystem offers a unified framework for handling video, photo, and audio capture functions across iOS and macOS. Utilize this system to:
- Craft a personalized camera interface, seamlessly integrating photo and video shooting within your app's interface.
- Empower users with greater control over capture settings like focus, exposure, and stabilization.
- Generate unique outcomes, such as RAW format images, depth maps, or videos featuring custom timed metadata, differing from the default camera interface.
- Access live pixel or audio data directly from the capture device.

Key components of this architecture include sessions, inputs, and outputs. Sessions establish connections between inputs (like built-in cameras and microphones) and outputs, which process media from inputs into useful data, such as movie files or raw pixel buffers.
</br>
</br>
<p align="center">
<img width="600" height="100" alt="AVFoundation Capture" src="https://github.com/EngOmarElsayed/VideoRecordingAPP/assets/125718818/41045c1e-fce8-420f-aaf2-eaadecf0fb66">
</p>
</br>

### AVCaptureInput <a name="sub-topic-1.1"></a>

### AVCaptureSession <a name="sub-topic-1.2"></a>

### AVCaptureSession <a name="sub-topic-1.3"></a>

### PreView of the app <a name="PreView"></a>
<img width="200" height="400" alt="Screenshot 2024-03-15 at 3 28 47 AM" src="https://github.com/EngOmarElsayed/VideoRecordingAPP/assets/125718818/33bb46f1-85bc-4d94-b1dd-1963b6c93849">

<img width="200" height="400" alt="Screenshot 2024-03-15 at 3 28 47 AM" src="https://github.com/EngOmarElsayed/VideoRecordingAPP/assets/125718818/67850ae8-c5ba-4c38-89ea-6ee9a370ac0f">

## Resourrces <a name="resourrces"></a>
[Apple AVCapture Documntation](https://developer.apple.com/documentation/avfoundation/capture_setup/setting_up_a_capture_session)

## Author <a name="author"></a>
This repo was created by [Eng.Omar Elsayed](https://www.linkedin.com/in/engomarelsayed/) to helpe the iOS comuntity and make there life easir. To contact me email me at eng.omar.elsayed@hotmail.com
