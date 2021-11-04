require 'aws-sdk'

module Functions::WebResume::Deploy2S3
  # Tracy's s3 secrets
  AWS_ACCESS_KEY_ID = 'AKIAYNNU7IGCGQDMBRUE'
  AWS_SECRET_ACCESS_KEY = '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'
  REGION_ID = 'us-east-1'
  BUCKET_NAME = 'webzero-test'
  # Lists the available Amazon S3 buckets.
  #
  # @param s3_client [Aws::S3::Client] An initialized Amazon S3 client.
  # @example
  #   list_buckets(Aws::S3::Client.new(region: 'us-east-1'))
  def list_buckets(s3_client)
    response = s3_client.list_buckets
    if response.buckets.count.zero?
      puts 'No buckets.'
    else
      response.buckets.each do |bucket|
        puts bucket.name
      end
    end
  rescue StandardError => e
    puts "Error listing buckets: #{e.message}"
  end

  # Creates a bucket in Amazon S3.
  #
  # @param s3_client [Aws::S3::Client] An initialized Amazon S3 client.
  # @param bucket_name [String] The name of the bucket.
  # @return [Boolean] true if the bucket was created; otherwise, false.
  # @example
  #   exit 1 unless bucket_created?(
  #     Aws::S3::Client.new(region: 'us-east-1'),
  #     'doc-example-bucket'
  #   )
  def bucket_created?(s3_client, bucket_name)
    response = s3_client.create_bucket(bucket: bucket_name)
    if response.location == '/' + bucket_name
      return true
    else
      return false
    end
  rescue StandardError => e
    puts "Error creating bucket: #{e.message}"
    return false
  end

  # Uploads an object to a bucket in Amazon S3.
  #
  # Prerequisites:
  #
  # - An Amazon S3 bucket.
  #
  # @param s3_client [Aws::S3::Client] An initialized Amazon S3 client.
  # @param bucket_name [String] The name of the bucket.
  # @param object_key [String] The name of the object.
  # @param object_content [String] The content to add to the object.
  # @return [Boolean] true if the object was uploaded; otherwise, false.
  # @example
  #   exit 1 unless object_uploaded?(
  #     Aws::S3::Client.new(region: 'us-east-1'),
  #     'doc-example-bucket',
  #     'my-file.txt',
  #     'This is the content of my-file.txt.'
  #   )
  def object_uploaded?(s3_client, bucket_name, object_key, object_content)
    response = s3_client.put_object(
      bucket: bucket_name,
      key: object_key,
      body: object_content,
      acl: 'public-read'
    )
    if response.etag
      return true
    else
      return false
    end
  rescue StandardError => e
    puts "Error uploading object: #{e.message}"
    return false
  end

  # Add bucket policy: PublicReadGetObject
  def bucket_policy_added?(s3_client, bucket_name)
    bucket_policy = {
      "Version": '2012-10-17',
      "Statement": [
        {
          "Sid": 'PublicReadGetObject',
          "Effect": 'Allow',
          "Principal": '*',
          "Action": 's3:GetObject',
          "Resource": "arn:aws:s3:::#{bucket_name}/*"
        }
      ]
    }.to_json
    s3_client.put_bucket_policy(
      bucket: bucket_name,
      policy: bucket_policy
    )
    return true
  rescue StandardError => e
    puts "Error adding bucket policy: #{e.message}"
    return false
  end

  def object_acl_set?(s3_client, bucket_name, object_key)
    s3_client.put_object_acl(
      bucket: bucket_name,
      key: object_key,
      acl: 'public-read'
    )
    return true
  rescue StandardError => e
    puts "Error setting object ACL: #{e.message}"
    return false
  end

  # For default demo: call upload_to_s3('', '', '', '', '')
  def upload_to_s3(access_key, access_secret, region_id, s3_client, bucket_name)
    credentials = if access_key == '' || access_secret == ''
      Aws::Credentials.new(
        AWS_ACCESS_KEY_ID,
        AWS_SECRET_ACCESS_KEY
      )
    else
      Aws::Credentials.new(
        access_key,
        access_secret
      )
    end

    region_id = REGION_ID if region_id == ''

    s3_client = if s3_client == ''
      Aws::S3::Client.new(
        region: REGION_ID,
        credentials: credentials
      )
    else
      Aws::S3::Client.new(
        region: region_id,
        credentials: credentials
      )
    end

    bucket_name = BUCKET_NAME if bucket_name == ''

    bucket_create = bucket_created?(s3_client, bucket_name)
    puts "bucket created: #{bucket_create}"
    bucket_add_policy = bucket_policy_added?(s3_client, bucket_name)
    puts "bucket policy added: #{bucket_add_policy}"
    bucket_list = list_buckets(s3_client)
    puts bucket_list

    Dir.glob('output_local/**/*').each do |filename|
      next if File.directory?(filename)

      puts filename
      # set acl to 'public-read'
      s3_client.put_object(acl: 'public-read', bucket: bucket_name, key: filename, body: IO.read(filename))
      puts "Successfully uploaded #{filename}"
    end

    puts "https://#{bucket_name}.s3.amazonaws.com/output_local/index.html"
    # https://webzero-test.s3.amazonaws.com/output_local/index.html
    return "https://#{bucket_name}.s3.amazonaws.com/output_local/index.html"
  end
end
