// stores changes to the API parameters for the current user session
// will display default listed parameters when user closes app and re opens it

class ApiValue {
  static String bucket = "momacmos3";
  static String project = "momacmo";
  static String folder = "meagerdas";
  static String dataset = "1432_aws_output_filt_5_50_despike";
  static String volume = "11";
  static String frame = "1";

  static String getBucket() {
    return bucket;
  }

  static String getProject() {
    return project;
  }

  static String getFolder() {
    return folder;
  }

  static String getDataset() {
    return dataset;
  }

  static String getVolume() {
    return volume;
  }

  static String getFrame() {
    return frame;
  }

  static void setBucket(String newBucket) {
    bucket = newBucket;
  }

  static void setProject(String newProject) {
    project = newProject;
  }

  static void setFolder(String newFolder) {
    folder = newFolder;
  }

  static void setDataset(String newDataset) {
    dataset = newDataset;
  }

  static void setVolume(String newVolume) {
    volume = newVolume;
  }

  static void setFrame(String newFrame) {
    frame = newFrame;
  }
}
