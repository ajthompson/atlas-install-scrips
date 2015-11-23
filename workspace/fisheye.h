#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include <iostream>
#include <fstream>
#include <stdio.h>
#include <stdlib.h>
#include <float.h>
#include <math.h>


#include <ros/ros.h>
#include <perception_common/MultisenseImage.h>
#include <perception_common/global.h>
#include <image_transport/image_transport.h>
#include <cv_bridge/cv_bridge.h>
#include <sensor_msgs/Image.h>
#include <unistd.h>
#include <sensor_msgs/image_encodings.h>




using namespace cv;
using namespace std;

#define CMV_MAX_BUF 1024
#define MAX_POL_LENGTH 64
#define   M_PI      3.14159265358979323846

struct ocam_model
{
  double pol[MAX_POL_LENGTH];    // the polynomial coefficients: pol[0] + x"pol[1] + x^2*pol[2] + ... + x^(N-1)*pol[N-1]
  int length_pol;                // length of polynomial
  double invpol[MAX_POL_LENGTH]; // the coefficients of the inverse polynomial
  int length_invpol;             // length of inverse polynomial
  double xc;         // row coordinate of the center
  double yc;         // column coordinate of the center
  double c;          // affine parameter
  double d;          // affine parameter
  double e;          // affine parameter
  int width;         // image width
  int height;        // image height
};

class fisheye{
	public:
		int sf;
		int num;
		double *array;
		CvMat* mapx_persp1;
		CvMat* mapx_persp2;
		CvMat* mapy_persp1;
		CvMat* mapy_persp2;
		Mat src1,src2 ;    
		Mat dst_persp1, dst_persp2 ;   
		cv::Mat mapx_persp_left;
		cv::Mat mapy_persp_left;
		cv::Mat mapx_persp_right;
		cv::Mat mapy_persp_right;

		int get_ocam_model(struct ocam_model *myocam_model, char *filename);
		void world2cam(double point2D[2], double point3D[3], struct ocam_model *myocam_model);
		void cam2world(double point3D[3], double point2D[2], struct ocam_model *myocam_model);
		void create_perspecive_undistortion_LUT( CvMat *mapx, CvMat *mapy, struct ocam_model *ocam_model, float sf);
		static void onTrackbar1(int, void*);
		static void onTrackbar2(int, void*);
		void rotate_image_90n(cv::Mat &src, cv::Mat &dst, int angle);
		void writeFile();


	fisheye(){
		sf = 10;
	}
};
