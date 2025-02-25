import boto3

def delete_unattached_volumes():
    """Deletes all unattached EBS volumes in the AWS account."""
    ec2 = boto3.client('ec2')
    
    try:

    # Get all volumes
        volumes = ec2.describe_volumes(Filters=[{'Name': 'status', 'Values': ['available']}])

        print(volumes)
        if not volumes['Volumes']:
            print("No unattached EBS volumes found.")
            return
        

    
        for volume in volumes['Volumes']:
            volume_id = volume['VolumeId']
            print(f"Deleting volume: {volume_id} ({volume['Size']} GiB)")
            ec2.delete_volume(VolumeId=volume_id)
            print(f"Deleted volume: {volume_id}")

    except Exception as e:
        #print(f"Failed to delete volume {volume_id}: {e}")
        print(f"Error: {str(e)}")

if __name__ == "__main__":
    delete_unattached_volumes()
