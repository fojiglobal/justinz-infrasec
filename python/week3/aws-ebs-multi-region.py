import boto3

def get_all_regions():
    """ Retrieve a list of all AWS regions """
    ec2 = boto3.client('ec2', region_name='us-east-2') # using default region to fetch the list
    regions = [region['RegionName'] for region in ec2.describe_regions()['Regions']]
    return regions

def delete_unattached_volumes_in_region(region):
    """Deletes all unattached EBS volumes in the AWS account."""
    ec2 = boto3.client('ec2', region_name=region)
    
    try:
        print(f"Checking region: {region}...")

    # Get all volumes
        volumes = ec2.describe_volumes(Filters=[{'Name': 'status', 'Values': ['available']}])['Volumes']

        #print(volumes)
        if not volumes:
            print(f"No unattached volumes found in {region}")
            return
        
        for volume in volumes:
            volume_id = volume['VolumeId']
            print(f"Deleting volume: {volume_id} ({volume['Size']} GiB) in {region}")
            ec2.delete_volume(VolumeId=volume_id)
            print(f"Deleted volume: {volume_id} in {region}")

    except Exception as e:
        #print(f"Failed to delete volume {volume_id}: {e}")
        print(f"Error in {region}: {str(e)}")

def delete_unattached_volumes_across_regions():
    """Iterate through all AWS regions and delete unattached volumes"""
    regions = get_all_regions()

    #print(regions)

    for region in regions:
        delete_unattached_volumes_in_region(region)

if __name__ == "__main__":
    delete_unattached_volumes_across_regions()
