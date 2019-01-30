Systems for counting vehicles should be fast enough to be implemented in real-time situations. Most of the related work uses two stages for vehicle counting, vehicle detection and tracking, which increases the computational complexity. In this Letter, a fast and efficient approach for vehicle counting is proposed, where there is no need for the vehicle tracking step. A background model is created only for a narrow region, a line, in the video frames. The moving vehicles are detected as foreground objects while passing this narrow region. Morphological processes are applied to the extracted objects to enhance them and decrease the effects of vehicle occlusions. Finally, an efficient counting vehicles method is introduced employing only the extracted detection information. The experimental results performed on diverse videos show that the proposed method is fast and accurate. The average execution time per frame is 7.78 ms.
