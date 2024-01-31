celeb=$1
mode=$2
# python manipulator/test.py --celeb <celeb_path> --checkpoints_dir ./manipulator_checkpoints --trg_emotions <emotions> --exp_name <exp_name>
if [ "$mode" = "train" ]
then
    echo "--------------- Preprocessing mode: train ---------------"
    echo
    python preprocessing/detect.py --celeb $celeb --split
    python preprocessing/eye_landmarks.py --celeb $celeb --mouth --align
    python preprocessing/segment_face.py --celeb $celeb
    python preprocessing/reconstruct.py --celeb $celeb \
                                        --save_shapes \
                                        --save_nmfcs
    python preprocessing/align.py --celeb $celeb --faces_and_masks \
                                                 --shapes \
                                                 --nmfcs \
                                                 --landmarks

elif [ "$mode" = "test" ]
then
  echo "--------------- Preprocessing mode: test ---------------"
  echo
  python preprocessing/detect.py --celeb $celeb --save_videos_info --save_full_frames
  python preprocessing/eye_landmarks.py --celeb $celeb --align
  python preprocessing/segment_face.py --celeb $celeb
  python preprocessing/reconstruct.py --celeb $celeb \
                                      --save_shapes \
                                      --save_nmfcs
  python preprocessing/align.py --celeb $celeb --faces_and_masks \
                                               --shapes \
                                               --nmfcs \
                                               --landmarks

else
    echo "Invalid mode given"
fi
